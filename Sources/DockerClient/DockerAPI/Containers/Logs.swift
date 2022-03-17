import Foundation

extension DockerAPI.Containers {

    struct Logs: StreamingEndpoint {

        typealias StreamItem = String

        private var containerId: String
        private var follow: Bool
        private var stdout: Bool
        private var stderr: Bool
        private var since: Int?
        private var until: Int?
        private var timestamps: Bool
        private var tail: Int?

        init(containerId: String,
             follow: Bool,
             stdout: Bool=true,
             stderr: Bool=true,
             since: Int?=nil,
             until: Int?=nil,
             timestamps: Bool=false,
             tail: Int?=nil
        ) {
            self.containerId = containerId
            self.follow = follow
            self.stdout = stdout
            self.stderr = stderr
            self.since = since
            self.until = until
            self.timestamps = timestamps
            self.tail = tail
        }

        var path: String {
            var url = URLComponents()
            url.path = "/containers/\(self.containerId)/logs"
            url.queryItems = [
                URLQueryItem(name: "follow", value: String(self.follow)),
                URLQueryItem(name: "stdout", value: String(self.stdout)),
                URLQueryItem(name: "stderr", value: String(self.stderr))
            ]
            if let since = self.since {
                url.queryItems?.append(URLQueryItem(name: "since", value: String(since)))
            }
            if let until = self.until {
                url.queryItems?.append(URLQueryItem(name: "until", value: String(until)))
            }
            if self.timestamps {
                url.queryItems?.append(URLQueryItem(name: "timestamps", value: "true"))
            }
            if let tail = self.tail {
                url.queryItems?.append(URLQueryItem(name: "tail", value: String(tail)))
            }

            return url.string!
        }

        func transformItem(item: String) -> String {
            return String(item.dropFirst(8))
        }
    }
}
