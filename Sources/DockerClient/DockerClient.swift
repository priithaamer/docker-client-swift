import Foundation
import AsyncHTTPClient
import NIOHTTP1

public class DockerClient {

    private let socket: String
    internal let client: HTTPClient

    public init(socket: String = "/var/run/docker.sock") {
        self.socket = socket
        self.client = HTTPClient(eventLoopGroupProvider: .createNew)
    }

    public func close() async throws {
        try await client.shutdown()
    }

    internal func request<T: Endpoint>(_ endpoint: T) async throws -> T.Response {
        return try await self.request(T.Response.self, uri: endpoint.path)
    }

    internal func request<T: Decodable>(_ t: T.Type, uri: String, method: HTTPMethod = .GET) async throws -> T {
        let socketPathBasedURL = URL(httpURLWithSocketPath: "/var/run/docker.sock", uri: uri)

        let request = try HTTPClient.Request(
            url: socketPathBasedURL!,
            method: method,
            headers: HTTPHeaders([("Host", "")])
        )

        let response = try await self.client.execute(request: request).get()

        guard let body = response.body else { throw DockerClientError.missingBody }

        if response.status == .ok {
            return try JSONDecoder().decode(t, from: body)
        } else {
            let parsedError = try JSONDecoder().decode(DockerAPI.Error.self, from: body)

            throw DockerAPIError.apiError(status: response.status.code, error: parsedError)
        }
    }
}

enum DockerClientError: Error {
    case missingBody
}
