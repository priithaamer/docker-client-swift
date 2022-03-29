import NIOHTTP1

struct StartContainerEndpoint: Endpoint {

    typealias Response = EmptyResponse

    var path: String {
        "/containers/\(self.id)/start"
    }

    var method: HTTPMethod = .POST

    private let id: String

    init(id: String) {
        self.id = id
    }
}
