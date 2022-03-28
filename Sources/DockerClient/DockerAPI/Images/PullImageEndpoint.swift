import Foundation
import NIOHTTP1

struct PullImageEndpoint: StreamingEndpoint {

    typealias StreamItem = PullStatus

    private let fromImage: String
    private let tag: String
    private let platform: String?
    private let jsonDecoder: JSONDecoder

    var method: HTTPMethod = .POST

    init(fromImage: String, tag: String="latest", platform: String?=nil) {
        self.fromImage = fromImage
        self.tag = tag
        self.platform = platform
        self.jsonDecoder = JSONDecoder()
    }

    var path: String {
        var url = URLComponents()
        url.path = "/images/create"
        url.queryItems = [
            URLQueryItem(name: "fromImage", value: self.fromImage),
            URLQueryItem(name: "tag", value: self.tag)
        ]
        url.queryItems?.append(URLQueryItem(name: "platform", value: self.platform))

        return url.string!
    }

    func transformItem(item: String) throws -> PullStatus {
        return try self.jsonDecoder.decode(PullStatus.self, from: item.data(using: .utf8)!)
    }
}
