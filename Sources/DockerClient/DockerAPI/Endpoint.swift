import Foundation

protocol Endpoint {
    associatedtype Response: Decodable

    var path: String { get }
}
