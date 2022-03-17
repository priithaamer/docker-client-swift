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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.repoTags = try container.decodeIfPresent([String].self, forKey: .repoTags)
        self.repoDigests = try container.decodeIfPresent([String].self, forKey: .repoDigests)
        self.size = try container.decode(Int.self, forKey: .size)
        self.virtualSize = try container.decodeIfPresent(Int.self, forKey: .virtualSize)
        self.sharedSize = try container.decodeIfPresent(Int.self, forKey: .sharedSize)
        self.labels = try container.decodeIfPresent([String: String].self, forKey: .labels)
        self.containers = try container.decodeIfPresent(Int.self, forKey: .containers)

        let timestamp = try container.decode(Int.self, forKey: .created)
        self.created = Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
}
