import Foundation

public struct CreatedContainer: Decodable {
    public let id: String
    public let warnings: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case warnings = "Warnings"
    }
}
