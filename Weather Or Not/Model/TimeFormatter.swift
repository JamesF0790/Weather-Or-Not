import UIKit

final class TimeFormatter {
    static func dateString(fromTimeStamp timestamp: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = Date(timeIntervalSince1970: timestamp)
        return formatter.string(from: date)
    }
}

