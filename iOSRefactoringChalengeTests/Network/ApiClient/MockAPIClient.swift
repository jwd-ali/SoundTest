import Foundation
import Combine
@testable import iOSRefactoringChallenge
final class MockAPIClient: ApiService {
    func request<T>(router: URLRequestConvertible) -> AnyPublisher<T, DataError> where T : Decodable {
        let filePath = "fakeTracks"
        return  self.loadJsonDataFromFile(filePath).compactMap { $0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> DataError in
                if let error = error as? DataError {
                    return error
                } else {
                    return DataError.serverError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private  func loadJsonDataFromFile(_ path: String) -> AnyPublisher<Data?, DataError> {
        guard let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") else { return Result.failure(DataError.unknown).publisher.eraseToAnyPublisher() }
           return Just(try? Data(contentsOf: fileUrl, options: []))
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
    }
}
