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

extension JSONDecoder.DateDecodingStrategy {
    public static var dockerDate: JSONDecoder.DateDecodingStrategy {
        return .custom({ decoder -> Date in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            if let date = DateFormatter.dockerDate.date(from: string) {
                return date
            }

            if let date = DateFormatter.dockerDateShort.date(from: string) {
                return date
            }

            throw DockerDateError.invalidDateString(date: string)
        })
    }
}

enum DockerDateError: Error {
    case invalidDateString(date: String)
}
