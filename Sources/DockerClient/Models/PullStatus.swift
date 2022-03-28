import Foundation

public enum PullStatus: Decodable {
    case progress(id: String, status: ProgressStatus, progressDetail: ProgressDetail)
    case status(id: String, status: String)
    case digest(digest: String)
    case error(error: String, errorDetail: ErrorDetail)
    case unknown

    enum CodingKeys: String, CodingKey {
        case id, status, progressDetail, errorDetail, error
    }

    // From: https://betterprogramming.pub/how-to-decode-dynamic-json-in-swift-5ca5f923aed1
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try? container.decode(String.self, forKey: .id),
           let status = try? container.decode(String.self, forKey: .status) {
            if let progressDetail = try? container.decode(ProgressDetail.self, forKey: .progressDetail) {
                self = .progress(id: id, status: ProgressStatus(from: status), progressDetail: progressDetail)
            } else {
                self = .status(id: id, status: status)
            }
        } else if let status = try? container.decode(String.self, forKey: .status) {
            self = .digest(digest: status)
        } else if let error = try? container.decode(String.self, forKey: .error),
                  let errorDetail = try? container.decode(ErrorDetail.self, forKey: .errorDetail) {
            self = .error(error: error, errorDetail: errorDetail)
        } else {
            self = .unknown
        }
    }

    public enum ProgressStatus {
        case pullingFsLayer
        case waiting
        case downloading
        case downloadComplete
        case extracting
        case verifyingChecksum
        case pullComplete
        case unknown

        public init(from: String) {
            if from.starts(with: "Pulling fs layer") {
                self = .pullingFsLayer
            } else if from.starts(with: "Waiting") {
                self = .waiting
            } else if from.starts(with: "Downloading") {
                self = .downloading
            } else if from.starts(with: "Download complete") {
                self = .downloadComplete
            } else if from.starts(with: "Extracting") {
                self = .extracting
            } else if from.starts(with: "Verifying Checksum") {
                self = .verifyingChecksum
            } else if from.starts(with: "Pull complete") {
                self = .pullComplete
            } else {
                self = .unknown
            }
        }
    }

    public struct ProgressDetail: Decodable {
        public let current: Int?
        public let total: Int?
    }

    public struct ErrorDetail: Decodable {
        struct Detail: Decodable {
            public let message: String
        }
    }
}
