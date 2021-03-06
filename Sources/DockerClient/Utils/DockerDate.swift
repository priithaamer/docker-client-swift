import Foundation

extension DateFormatter {
    static var dockerDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSS'Z'"
        return formatter
    }

    static var dockerDateShort: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }
}

extension Date {
    static func dateFromDockerDate(string: String) throws -> Date {
        guard let date = DateFormatter.dockerDate.date(from: string) else {
            throw DockerDateError.invalidDateString(date: string)
        }

        return date
    }
}

extension JSONDecoder.DateDecodingStrategy {
    public static var dockerDate: JSONDecoder.DateDecodingStrategy {
        return .custom({ decoder -> Date in
            let container = try decoder.singleValueContainer()

            if let string = try? container.decode(String.self) {
                if let date = DateFormatter.dockerDate.date(from: string) {
                    return date
                }

                if let date = DateFormatter.dockerDateShort.date(from: string) {
                    return date
                }

                throw DockerDateError.invalidDateString(date: string)
            }

            if let timestamp = try? container.decode(Int.self) {
                return Date(timeIntervalSince1970: TimeInterval(timestamp))
            }

            throw DockerDateError.invalidDate
        })
    }
}

enum DockerDateError: Error {
    case invalidDate
    case invalidDateString(date: String)
}
