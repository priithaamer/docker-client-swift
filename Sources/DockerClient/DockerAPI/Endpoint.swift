import Foundation
import NIOHTTP1

protocol Endpoint {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    public var method: HTTPMethod {
        return .GET
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
