import Foundation

public struct ContainerDetails: Decodable {
    public let id: String
    public let created: Date
    public let path: String
    public let args: [String]
    public let state: ContainerState
    public let image: String
    public let resolvConfPath: String
    public let hostnamePath: String
    public let hostsPath: String
    public let logPath: String
    public let name: String
    public let restartCount: Int
    public let driver: String
    public let platform: String
    public let mountLabel: String
    public let processLabel: String
    public let appArmorProfile: String
    public let execIDs: [String]?

    public let sizeRw: Int?
    public let sizeRootFs: Int?
    public let mounts: [MountPoint]
    public let config: ContainerConfig

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case created = "Created"
        case path = "Path"
        case args = "Args"
        case state = "State"
        case image = "Image"
        case resolvConfPath = "ResolvConfPath"
        case hostnamePath = "HostnamePath"
        case hostsPath = "HostsPath"
        case logPath = "LogPath"
        case name = "Name"
        case restartCount = "RestartCount"
        case driver = "Driver"
        case platform = "Platform"
        case mountLabel = "MountLabel"
        case processLabel = "ProcessLabel"
        case appArmorProfile = "AppArmorProfile"
        case execIDs = "ExecIDs"

        case sizeRw = "SizeRw"
        case sizeRootFs = "SizeRootFs"
        case mounts = "Mounts"
        case config = "Config"
    }

    public struct ContainerState: Decodable {
        public let status: String
        public let running: Bool
        public let paused: Bool
        public let restarting: Bool
        public let oomKilled: Bool
        public let dead: Bool
        public let pid: Int
        public let exitCode: Int
        public let error: String
        public let startedAt: Date
        public let finishedAt: Date
        public let health: Health?

        enum CodingKeys: String, CodingKey {
            case status = "Status"
            case running = "Running"
            case paused = "Paused"
            case restarting = "Restarting"
            case oomKilled = "OOMKilled"
            case dead = "Dead"
            case pid = "Pid"
            case exitCode = "ExitCode"
            case error = "Error"
            case startedAt = "StartedAt"
            case finishedAt = "FinishedAt"
            case health = "Health"
        }

        public struct Health: Decodable {
            public let status: String
            public let failingStreak: Int
            public let log: [HealthCheckResult]

            enum CodingKeys: String, CodingKey {
                case status = "Status"
                case failingStreak = "FailingStreak"
                case log = "Log"
            }

            public struct HealthCheckResult: Decodable {
                public let start: Date
                public let end: Date
                public let exitCode: Int
                public let output: String?

                enum CodingKeys: String, CodingKey {
                    case start = "Start"
                    case end = "End"
                    case exitCode = "ExitCode"
                    case output = "Output"
                }
            }
        }
    }

    public struct MountPoint: Decodable {
        public let kind: String
        public let name: String
        public let source: String
        public let destination: String
        public let driver: String
        public let mode: String
        public let rw: Bool
        public let propagation: String

        enum CodingKeys: String, CodingKey {
            case kind = "Type"
            case name = "Name"
            case source = "Source"
            case destination = "Destination"
            case driver = "Driver"
            case mode = "Mode"
            case rw = "RW"
            case propagation = "Propagation"
        }
    }

    public struct ContainerConfig: Decodable {
        public let hostname: String
        public let domainname: String
        public let user: String
        public let attachStdin: Bool
        public let attachStdout: Bool
        public let attachStderr: Bool
        public let exposedPorts: [String: String]?
        public let tty: Bool
        public let openStdin: Bool
        public let stdinOnce: Bool
        public let env: [String]
        public let cmd: [String]
        public let healthCheck: HealthConfig?
        public let argsEscaped: Bool?
        public let image: String
        public let volumes: [String: String]?
        public let workingDir: String
        public let entrypoint: [String]?
        public let networkDisabled: Bool?
        public let macAddress: String?
        public let onBuild: [String]?
        public let labels: [String: String]?
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
            case exposedPorts = "ExposedPorts"
            case tty = "Tty"
            case openStdin = "OpenStdin"
            case stdinOnce = "StdinOnce"
            case env = "Env"
            case cmd = "Cmd"
            case healthCheck = "HealthCheck"
            case argsEscaped = "ArgsEscaped"
            case image = "Image"
            case volumes = "Volumes"
            case workingDir = "WorkingDir"
            case entrypoint = "Entrypoint"
            case networkDisabled = "NetworkDisabled"
            case macAddress = "MacAddress"
            case onBuild = "OnBuild"
            case labels = "Labels"
            case stopSignal = "StopSignal"
            case stopTimeout = "StopTimeout"
            case shell = "Shell"
        }

        public struct HealthConfig: Decodable {
            public let test: [String]
            public let interval: Int
            public let timeout: Int
            public let retries: Int
            public let startPeriod: Int

            enum CodingKeys: String, CodingKey {
                case test = "Test"
                case interval = "Interval"
                case timeout = "Timeout"
                case retries = "Retries"
                case startPeriod = "StartPeriod"
            }
        }
    }
}
