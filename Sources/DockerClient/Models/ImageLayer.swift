import Foundation

public struct ImageLayer: Decodable {
    public let id: String
    public let created: Date
    public let createdBy: String
    public let tags: [String]?
    public let size: Int
    public let comment: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case created = "Created"
        case createdBy = "CreatedBy"
        case tags = "Tags"
        case size = "Size"
        case comment = "Comment"
    }
}
