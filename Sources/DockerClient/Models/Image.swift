import Foundation

public struct Image: Decodable {
    public let id: String
    public let repoTags: [String]?
    public let repoDigests: [String]?
    public let created: Date
    public let size: Int
    public let virtualSize: Int?
    public let sharedSize: Int?
    public let labels: [String: String]?
    public let containers: Int?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case repoTags = "RepoTags"
        case repoDigests = "RepoDigests"
        case created = "Created"
        case size = "Size"
        case virtualSize = "VirtualSize"
        case sharedSize = "SharedSize"
        case labels = "Labels"
        case containers = "Containers"
    }
}
