import NIOHTTP1
import Foundation

struct RemoveContainerEndpoint: Endpoint {

    typealias Response = EmptyResponse

    private let id: String
    private let removeVolumes: Bool
    private let force: Bool
    private let link: Bool

    var path: String {
        var url = URLComponents()
        url.path = "/containers/\(self.id)"
        url.queryItems = []
        if self.removeVolumes {
            url.queryItems?.append(URLQueryItem(name: "v", value: "true"))
        }
        if self.force {
            url.queryItems?.append(URLQueryItem(name: "force", value: "true"))
        }
        if self.link {
            url.queryItems?.append(URLQueryItem(name: "link", value: "true"))
        }

        return url.string!
    }

    var method: HTTPMethod = .DELETE

    init(id: String, removeVolumes: Bool = false, force: Bool = false, link: Bool = false) {
        self.id = id
        self.removeVolumes = removeVolumes
        self.force = force
        self.link = link
    }
}
