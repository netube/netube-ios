import Foundation

extension URL {
        static func new(_ address: String) -> URL {
                return URL(string: address) ?? URL(string: "https://netube.org")!
        }
}
