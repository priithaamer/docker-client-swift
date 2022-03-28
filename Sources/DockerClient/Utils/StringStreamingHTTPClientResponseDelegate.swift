import AsyncHTTPClient
import NIOCore

class StringStreamingHTTPClientResponseDelegate: HTTPClientResponseDelegate {

    var onLineReceived: ((String) -> Void)?

    var onFinished: (() -> Void)?

    func didReceiveBodyPart(task: HTTPClient.Task<Bool>, _ buffer: ByteBuffer) -> EventLoopFuture<Void> {
        let lines = String(buffer: buffer).split(whereSeparator: \.isNewline)

        for line in lines {
            if let onLineReceived = self.onLineReceived {
                onLineReceived(String(line))
            }
        }

        return task.eventLoop.makeSucceededVoidFuture()
    }

    func didReceiveError(task: HTTPClient.Task<Bool>, _ error: Error) {
        if let onFinished = self.onFinished {
            onFinished()
        }
    }

    func didFinishRequest(task: HTTPClient.Task<Bool>) throws -> Bool {
        if let onFinished = self.onFinished {
            onFinished()
        }

        return true
    }

    typealias Response = Bool
}
