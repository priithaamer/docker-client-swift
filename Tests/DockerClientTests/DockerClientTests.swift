import XCTest
@testable import DockerClient

final class DockerClientTests: XCTestCase {
    var docker: DockerClient!

    override func setUp() {
        self.docker = DockerClient()
    }

    override func tearDown() async throws {
        try await self.docker.close()
    }

    func testImages() async throws {
        XCTAssertEqual("Hello, World!", "Hello, World!")
    }
}
