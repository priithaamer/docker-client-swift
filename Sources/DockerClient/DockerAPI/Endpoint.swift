import Foundation

protocol Endpoint {
    associatedtype Response: Decodable

    var path: String { get }
}

protocol StreamingEndpoint {
    associatedtype StreamItem: Decodable = String

    var path: String { get }

    func transformItem(item: String) throws -> StreamItem
}

