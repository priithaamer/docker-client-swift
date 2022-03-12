import Foundation

public struct Container {
    public var id: String
    public var names: [String]
    public var image: String
    public var imageId: String
    public var command: String
    public var created: Date
    public var ports: [ContainerPort]
    public var sizeRw: Int64?
    public var sizeRootFs: Int64?
    public var labels: [String: String]?
    public var state: String
    public var status: String
    public var mounts: [ContainerMount]
}

public struct ContainerPort {
    public var ip: String
    public var privatePort: UInt
    public var publicPort: UInt?
}

public struct ContainerMount {
    public var name: String
    public var source: String
    public var destination: String
    public var driver: String
    public var mode: String
    public var rw: Bool
    public var propagation: String
}
