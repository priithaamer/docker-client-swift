extension DockerClient {

    public var images: Images {
        Images(client: self)
    }

    public struct Images {
        internal var client: DockerClient

        public func list(all: Bool=false) async throws -> [Image] {
            return try await self.client.request(ListImagesEndpoint(all: all))
        }
    }
}
