import Foundation

extension DockerClient {

    public var containers: Containers {
        Containers(client: self)
    }

    public struct Containers {

        internal var client: DockerClient

        public func list(all: Bool=false) async throws -> [Container] {
            return try await client.request(DockerAPI.Containers.List(all: all)).map(Container.fromListContainers)
        }

        }
    }
}

extension Container {
    static func fromListContainers(_ container: DockerAPI.Containers.List.Container) -> Container {
        return Container(id: container.Id,
                         names: container.Names,
                         image: container.Image,
                         imageId: container.ImageID,
                         command: container.Command,
                         created: Date(timeIntervalSince1970: TimeInterval(container.Created)),
                         ports: container.Ports.map(ContainerPort.fromListContainers),
                         sizeRw: container.SizeRw,
                         sizeRootFs: container.SizeRootFs,
                         labels: container.Labels,
                         state: container.State,
                         status: container.Status,
                         mounts: container.Mounts.map(ContainerMount.fromListContainers))
    }
}

extension ContainerPort {
    static func fromListContainers(_ port: DockerAPI.Containers.List.ContainerPort) -> ContainerPort {
        return ContainerPort(ip: port.IP, privatePort: port.PrivatePort, publicPort: port.PublicPort, kind: port.Kind)
    }
}

extension ContainerMount {
    static func fromListContainers(_ mount: DockerAPI.Containers.List.ContainerMount) -> ContainerMount {
        return ContainerMount(name: mount.Name,
                              source: mount.Source,
                              destination: mount.Destination,
                              driver: mount.Driver,
                              kind: mount.Kind,
                              mode: mount.Mode,
                              rw: mount.RW,
                              propagation: mount.Propagation)
    }
}
