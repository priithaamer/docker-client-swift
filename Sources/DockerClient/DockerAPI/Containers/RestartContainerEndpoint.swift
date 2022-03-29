import NIOHTTP1
import Foundation

struct RestartContainerEndpoint: Endpoint {

    typealias Response = EmptyResponse

    private let id: String
    private let wait: Int?

    var path: String {
        var url = URLComponents()
        url.path = "/containers/\(self.id)/restart"
        url.queryItems = []
        if let wait = self.wait {
            url.queryItems?.append(URLQueryItem(name: "t", value: String(wait)))
        }

        return url.string!
    }

    var method: HTTPMethod = .POST

    init(id: String, wait: Int? = nil) {
        self.id = id
        self.wait = wait
    }
}
