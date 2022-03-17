import Foundation

public struct Container: Decodable {
    public let id: String
    public let names: [String]
    public let image: String
    public let imageId: String
    public let command: String
    public let created: Int
    public let ports: [ContainerPort]
    public let sizeRw: Int64?
    public let sizeRootFs: Int64?
    public let labels: [String: String]?
    public let state: String
    public let status: String
    public let mounts: [ContainerMount]

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case names = "Names"
        case image = "Image"
        case imageId = "ImageID"
        case command = "Command"
        case created = "Created"
        case ports = "Ports"
        case sizeRw = "SizeRw"
        case sizeRootFs = "SizeRootFs"
        case labels = "Labels"
        case state = "State"
        case status = "Status"
        case mounts = "Mounts"
    }
}

public struct ContainerPort: Decodable {
    public let ip: String
    public let privatePort: UInt
    public let publicPort: UInt?
    public let kind: String

    enum CodingKeys: String, CodingKey {
        case ip = "IP"
        case privatePort = "PrivatePort"
        case publicPort = "PublicPort"
        case kind = "Type"
    }
}

public struct ContainerMount: Decodable {
    public let name: String?
    public let source: String
    public let destination: String
    public let driver: String?
    public let kind: String
    public let mode: String
    public let rw: Bool
    public let propagation: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case source = "Source"
        case destination = "Destination"
        case driver = "Driver"
        case kind = "Type"
        case mode = "Mode"
        case rw = "RW"
        case propagation = "Propagation"
    }
}
