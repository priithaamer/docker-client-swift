import Foundation

struct ContainerStatsEndpoint: StreamingEndpoint {

    typealias StreamItem = ResourceUsage

    private let containerId: String
    private let stream: Bool
    private let jsonDecoder: JSONDecoder


    init(containerId: String, stream: Bool) {
        self.containerId = containerId
        self.stream = stream

        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.dateDecodingStrategy = .dockerDate
    }

    var path: String {
        "/containers/\(self.containerId)/stats?stream=\(self.stream)"
    }

    func transformItem(item: String) throws -> ResourceUsage {
        return try self.jsonDecoder.decode(ResourceUsage.self, from: item.data(using: .utf8)!)
    }
}
