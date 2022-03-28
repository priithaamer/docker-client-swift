import Foundation

public struct ImageDetails: Decodable {
    public let id: String
    public let repoTags: [String]?
    public let repoDigests: [String]?
    public let parent: String
    public let comment: String
    public let created: Date
    public let container: String
    public let containerConfig: ContainerConfig?
    public let dockerVersion: String
    public let author: String
    public let config: ContainerConfig?
    public let architecture: String
    public let os: String
    public let osVersion: String?
    public let size: Int
    public let virtualSize: Int?
    public let graphDriver: GraphDriver
    public let rootFs: RootFS
    public let metadata: Metadata?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case repoTags = "RepoTags"
        case repoDigests = "RepoDigests"
        case parent = "Parent"
        case comment = "Comment"
        case created = "Created"
        case container = "Container"
        case containerConfig = "ContainerConfig"
        case dockerVersion = "DockerVersion"
        case author = "Author"
        case config = "Config"
        case architecture = "Architecture"
        case os = "Os"
        case osVersion = "OsVersion"
        case size = "Size"
        case virtualSize = "VirtualSize"
        case graphDriver = "GraphDriver"
        case rootFs = "RootFS"
        case metadata = "Metadata"
    }

    public struct ContainerConfig: Decodable {
        public let hostname: String?
        public let domainname: String?
        public let user: String?
        public let attachStdin: Bool?
        public let attachStdout: Bool?
        public let attachStderr: Bool?
        public let tty: Bool?
        public let openStdin: Bool?
        public let stdinOnce: Bool?
        public let env: [String]?
        public let cmd: [String]?
        public let image: String?
        public let workingDir: String?
        public let entrypoint: [String]?
        public let networkDisabled: Bool?
        public let macAddress: String?
        public let onBuild: [String]?
        public let stopSignal: String?
        public let stopTimeout: Int?
        public let shell: [String]?

        enum CodingKeys: String, CodingKey {
            case hostname = "Hostname"
            case domainname = "Domainname"
            case user = "User"
            case attachStdin = "AttachStdin"
            case attachStdout = "AttachStdout"
            case attachStderr = "AttachStderr"
            case tty = "Tty"
            case openStdin = "OpenStdin"
            case stdinOnce = "StdinOnce"
            case env = "Env"
            case cmd = "Cmd"
            case image = "Image"
            case workingDir = "WorkingDir"
            case entrypoint = "Entrypoint"
            case networkDisabled = "NetworkDisabled"
            case macAddress = "MacAddress"
            case onBuild = "OnBuild"
            case stopSignal = "StopSignal"
            case stopTimeout = "StopTimeout"
            case shell = "Shell"
        }
    }

    public struct GraphDriver: Decodable {
        public let name: String
        public let data: [String: String]?

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case data = "Data"
        }
    }

    public struct RootFS: Decodable {
        public let kind: String
        public let layers: [String]?
        public let baseLayer: String?

        enum CodingKeys: String, CodingKey {
            case kind = "Type"
            case layers = "Layers"
            case baseLayer = "BaseLayer"
        }
    }

    public struct Metadata: Decodable {
        public let lastTagTime: String?

        enum CodingKeys: String, CodingKey {
            case lastTagTime = "LastTagTime"
        }
    }
}

