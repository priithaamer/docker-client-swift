enum DockerAPI {
}

enum DockerAPIError: Error {
    case apiError(status: UInt, error: DockerAPI.Error)
}

extension DockerAPI {
    public struct Error: Decodable {
        let message: String
    }
}
