import Foundation
enum DataError: Error {
    case unknown
    case requestError
    case notConnected
    case serverError(error: String)
}
