struct ListContainersEndpoint: Endpoint {

    typealias Response = [Container]

    private var all: Bool

    init(all: Bool) {
        self.all = all
    }

    var path: String {
        "/containers/json?all=\(all)"
    }
}
