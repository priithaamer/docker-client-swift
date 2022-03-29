import NIOHTTP1

struct StopContainerEndpoint: Endpoint {

    typealias Response = EmptyResponse

    var path: String {
        "/containers/\(self.id)/stop"
    }

    var method: HTTPMethod = .POST

    private let id: String

    init(id: String) {
        self.id = id
    }
}
