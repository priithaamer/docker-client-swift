import Foundation

public enum RemovedImageLayer: Decodable {
    case untagged(imageId: String)
    case deleted(imageId: String)
    case unknown

    enum CodingKeys: String, CodingKey {
        case untagged = "Untagged"
        case deleted = "Deleted"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let imageId = try? container.decode(String.self, forKey: .untagged) {
            self = .untagged(imageId: imageId)
        } else if let imageId = try? container.decode(String.self, forKey: .deleted) {
            self = .deleted(imageId: imageId)
        } else {
            self = .unknown
        }
    }
}
