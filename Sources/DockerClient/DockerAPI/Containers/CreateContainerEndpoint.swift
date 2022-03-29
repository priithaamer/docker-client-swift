import Foundation
import NIOHTTP1

struct CreateContainerEndpoint: Endpoint {

    typealias Request = CreateContainerRequest
    typealias Response = CreatedContainer

    var path: String {
        "/containers/create"
    }

    var method: HTTPMethod = .POST

    var body: CreateContainerRequest?

    init(image: String, cmd: [String]? = nil) {
        self.body = CreateContainerRequest(image: image, cmd: cmd)
    }

    struct CreateContainerRequest: Codable {
        public let image: String?
        public let cmd: [String]?

        enum CodingKeys: String, CodingKey {
            case image = "Image"
            case cmd = "Cmd"
        }
    }
}
