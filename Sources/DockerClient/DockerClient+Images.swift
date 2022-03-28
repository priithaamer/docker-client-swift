extension DockerClient {

    public var images: Images {
        Images(client: self)
    }

    public struct Images {
        internal var client: DockerClient

        public func list(all: Bool=false) async throws -> [Image] {
            return try await self.client.request(ListImagesEndpoint(all: all))
        }

        public func inspect(name: String) async throws -> ImageDetails {
            return try await self.client.request(InspectImageEndpoint(imageId: name))
        }

        public func pull(name: String, tag: String = "latest", onProgress: (String, PullStatus.ProgressStatus, PullStatus.ProgressDetail) -> Void) async throws -> ImageDetails {
            for await pullStatus in try self.client.stream(PullImageEndpoint(fromImage: name, tag: tag)) {
                switch pullStatus {
                case .progress(id: let id, status: let status, progressDetail: let progressDetail):
                    onProgress(id, status, progressDetail)
                default: break
                }
            }

            return try await self.inspect(name: name)
        }

        public func history(name: String) async throws -> [ImageLayer] {
            return try await self.client.request(ImageHistoryEndpoint(name: name))
        }
    }
}
