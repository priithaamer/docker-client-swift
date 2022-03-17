extension DockerAPI.Containers {
    
    struct List: Endpoint {

        typealias Response = [Container]

        private var all: Bool

        init(all: Bool) {
            self.all = all
        }

        var path: String {
            "/containers/json?all=\(all)"
        }

        struct ContainerPort: Decodable {
            let IP: String
            let PrivatePort: UInt
            let PublicPort: UInt?
            let Kind: String

            enum CodingKeys: String, CodingKey {
                case IP, PrivatePort, PublicPort
                case Kind = "Type"
            }
        }

        struct ContainerMount: Decodable {
            let Name: String?
            let Source: String
            let Destination: String
            let Driver: String?
            let Kind: String
            let Mode: String
            let RW: Bool
            let Propagation: String

            enum CodingKeys: String, CodingKey {
                case Name, Source, Destination, Driver, Mode, RW, Propagation
                case Kind = "Type"
            }
        }

        struct Container: Decodable {
            let Id: String
            let Names: [String]
            let Image: String
            let ImageID: String
            let Command: String
            let Created: Int64
            let Ports: [ContainerPort]
            let SizeRw: Int64?
            let SizeRootFs: Int64?
            let Labels: [String: String]?
            let State: String
            let Status: String
            let Mounts: [ContainerMount]
        }
    }
}
