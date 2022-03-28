import Foundation

struct InspectImageEndpoint: Endpoint {

    typealias Response = ImageDetails

    private let imageId: String

    init(imageId: String) {
        self.imageId = imageId
    }

    var path: String {
        var url = URLComponents()
        url.path = "/images/\(self.imageId)/json"

        return url.string!
    }
}
