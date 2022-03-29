import Foundation
import NIOHTTP1

struct DefaultRequest: Encodable {}

struct EmptyResponse: Decodable {}

protocol Endpoint {
    associatedtype Request: Encodable = DefaultRequest
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var body: Request? { get }
}

extension Endpoint {
    public var method: HTTPMethod {
        return .GET
    }

    public var body: Request? {
        return nil
    }
}

protocol StreamingEndpoint {
    associatedtype StreamItem: Decodable = String

    var path: String { get }
    var method: HTTPMethod { get }

    func transformItem(item: String) throws -> StreamItem
}

extension StreamingEndpoint {
    public var method: HTTPMethod {
        return .GET
    }
}
