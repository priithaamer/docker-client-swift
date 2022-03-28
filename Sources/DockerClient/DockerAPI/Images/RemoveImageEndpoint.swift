import NIOHTTP1
import Foundation

struct RemoveImageEndpoint: Endpoint {

    typealias Response = [RemovedImageLayer]

    private let name: String
    private let force: Bool
    private let noPrune: Bool

    var method: HTTPMethod = .DELETE

    var path: String {
        var url = URLComponents()
        url.path = "/images/\(self.name)"
        url.queryItems = []
        if self.force {
            url.queryItems?.append(URLQueryItem(name: "force", value: "true"))
        }
        if self.noPrune {
            url.queryItems?.append(URLQueryItem(name: "noprune", value: "true"))
        }

        return url.string!
    }

    init(name: String, force: Bool = false, noPrune: Bool = false) {
        self.name = name
        self.force = force
        self.noPrune = noPrune
    }
}
