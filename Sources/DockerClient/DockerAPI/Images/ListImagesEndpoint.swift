import Foundation

struct ListImagesEndpoint: Endpoint {

    typealias Response = [Image]

    private let all: Bool

    init(all: Bool) {
        self.all = all
    }

    var path: String {
        var url = URLComponents()
        url.path = "/images/json"
        if self.all {
            url.queryItems?.append(URLQueryItem(name: "all", value: "true"))
        }

        return url.string!
    }
}
