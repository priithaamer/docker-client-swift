import Foundation
import AsyncHTTPClient
import NIOHTTP1
import Logging

public class DockerClient {

    private let socket: String
    private let client: HTTPClient
    private let logger: Logger

    public init(socket: String = "/var/run/docker.sock") {
        self.socket = socket
        self.client = HTTPClient(eventLoopGroupProvider: .createNew)
        self.logger = Logger(label: "DockerClient")
    }

    public func close() async throws {
        try await client.shutdown()
    }

    internal func request<T: Endpoint>(_ endpoint: T) async throws -> T.Response {
        return try await self.request(T.Response.self, uri: endpoint.path, method: endpoint.method)
    }

    internal func request<T: Decodable>(_ t: T.Type, uri: String, method: HTTPMethod = .GET) async throws -> T {
        let socketPathBasedURL = URL(httpURLWithSocketPath: "/var/run/docker.sock", uri: uri)

        let request = try HTTPClient.Request(
            url: socketPathBasedURL!,
            method: method,
            headers: HTTPHeaders([("Host", "")])
        )

        let response = try await self.client.execute(request: request).get()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .dockerDate

        guard let body = response.body else { throw DockerClientError.missingBody }

        if response.status == .ok {
            return try decoder.decode(t, from: body)
        } else {
            let parsedError = try decoder.decode(DockerAPI.Error.self, from: body)

            throw DockerAPIError.apiError(status: response.status.code, error: parsedError)
        }
    }

    internal func stream<T: StreamingEndpoint>(_ endpoint: T) throws -> AsyncStream<T.StreamItem> {
        return try self.stream(uri: endpoint.path, method: endpoint.method, mapFn: endpoint.transformItem)
    }

    internal func stream<T: Decodable>(uri: String, method: HTTPMethod, mapFn: @escaping (String) throws -> T) throws -> AsyncStream<T> {
        let socketPathBasedURL = URL(httpURLWithSocketPath: "/var/run/docker.sock", uri: uri)

        let streamingDelegate = StringStreamingHTTPClientResponseDelegate()

        let request = try HTTPClient.Request(url: socketPathBasedURL!, method: method, headers: HTTPHeaders([("Host", "")]))
        let response = self.client.execute(request: request, delegate: streamingDelegate)

        let stream = AsyncStream<T> { continuation in
            streamingDelegate.onLineReceived = { line in
                do {
                    try continuation.yield(mapFn(line))
                } catch {
                    self.logger.warning("Failed transforming stream item: \(error). Item: \(line). URI: \(uri)")
                }
            }

            streamingDelegate.onFinished = {
                continuation.finish()
            }

            continuation.onTermination = { @Sendable _ in
                response.cancel()
            }
        }

        return stream
    }
}

enum DockerClientError: Error {
    case missingBody
}
