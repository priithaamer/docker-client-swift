import NIOHTTP1
import Foundation

struct KillContainerEndpoint: Endpoint {

    typealias Response = EmptyResponse

    private let id: String
    private let signal: String?

    var path: String {
        var url = URLComponents()
        url.path = "/containers/\(self.id)/kill"
        url.queryItems = []
        if let signal = self.signal {
            url.queryItems?.append(URLQueryItem(name: "signal", value: signal))
        }

        return url.string!
    }

    var method: HTTPMethod = .POST

    init(id: String, signal: String? = nil) {
        self.id = id
        self.signal = signal
    }
}
