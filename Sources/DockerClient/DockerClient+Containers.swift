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
            return try self.client.stream(ContainerStatsEndpoint(containerId: container.id, stream: stream))
        }
    }
}
