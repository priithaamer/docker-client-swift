import Foundation

extension DockerClient {

    public var containers: Containers {
        Containers(client: self)
    }

    public struct Containers {

        internal var client: DockerClient

        public func list(all: Bool=false) async throws -> [Container] {
            return try await client.request(ListContainersEndpoint(all: all))
        }

        public func create(image: String, cmd: [String]? = nil) async throws -> CreatedContainer {
            return try await client.request(CreateContainerEndpoint(image: image, cmd: cmd))
        }

        public func start(id: String) async throws -> Void {
            _ = try await client.request(StartContainerEndpoint(id: id))
        }

        public func stop(id: String) async throws -> Void {
            _ = try await client.request(StopContainerEndpoint(id: id))
        }

        public func restart(id: String, wait: Int? = nil) async throws -> Void {
            _ = try await client.request(RestartContainerEndpoint(id: id, wait: wait))
        }

        public func kill(id: String, signal: String? = nil) async throws -> Void {
            _ = try await client.request(KillContainerEndpoint(id: id, signal: signal))
        }

        public func remove(id: String, removeVolumes: Bool = false, force: Bool = false, link: Bool = false) async throws -> Void {
            _ = try await client.request(RemoveContainerEndpoint(id: id, removeVolumes: removeVolumes, force: force, link: link))
        }

        public func inspect(id: String, size: Bool = false) async throws -> ContainerDetails {
            return try await client.request(InspectContainerEndpoint(id: id, size: size))
        }

        public func logs(container: Container, follow: Bool = true, timestamps: Bool = false, tail: Int? = nil) throws -> AsyncStream<String> {
            return try self.logs(containerId: container.id, follow: follow, timestamps: timestamps, tail: tail)
        }

        public func logs(container: ContainerDetails, follow: Bool = true, timestamps: Bool = true, tail: Int? = nil) throws -> AsyncStream<String> {
            return try self.logs(containerId: container.id, follow: follow, timestamps: timestamps, tail: tail)
        }

        public func logs(containerId: String, follow: Bool = true, timestamps: Bool = true, tail: Int? = nil) throws -> AsyncStream<String> {
            return try self.client.stream(ContainerLogsEndpoint(containerId: containerId, follow: follow, timestamps: timestamps, tail: tail))
        }

        public func stats(container: Container, stream: Bool=true) throws -> AsyncStream<ResourceUsage> {
            return try self.stats(containerId: container.id, stream: stream)
        }

        public func stats(container: ContainerDetails, stream: Bool = true) throws -> AsyncStream<ResourceUsage> {
            return try self.stats(containerId: container.id, stream: stream)
        }

        public func stats(containerId: String, stream: Bool = true) throws -> AsyncStream<ResourceUsage> {
            return try self.client.stream(ContainerStatsEndpoint(containerId: containerId, stream: stream))
        }
    }
}
