import Foundation

struct ImageHistoryEndpoint: Endpoint {

    typealias Response = [ImageLayer]

    private let name: String

    init(name: String) {
        self.name = name
    }

    var path: String {
        var url = URLComponents()
        url.path = "/images/\(self.name)/history"

        return url.string!
    }
}
