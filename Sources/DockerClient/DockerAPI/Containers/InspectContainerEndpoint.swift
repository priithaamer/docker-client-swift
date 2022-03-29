import Foundation

struct InspectContainerEndpoint: Endpoint {

    typealias Response = ContainerDetails

    private let id: String
    private let size: Bool

    init(id: String, size: Bool = false) {
        self.id = id
        self.size = size
    }

    var path: String {
        var url = URLComponents()
        url.path = "/containers/\(self.id)/json"
        url.queryItems = []
        if self.size {
            url.queryItems?.append(URLQueryItem(name: "size", value: "true"))
        }

        return url.string!
    }
}
