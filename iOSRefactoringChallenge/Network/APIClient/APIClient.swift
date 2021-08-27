import Combine
import Foundation

public protocol URLRequestConvertible {
    func urlRequest() throws -> URLRequest
}

class APIClient {
    private let session = URLSession(configuration: .default)
    private func execute(request: URLRequest?) -> AnyPublisher<Data, DataError> {
        guard let urlRequest = request else {
            return Fail(error: DataError.requestError)
                .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                String(data: data, encoding: .utf8).map { Log.d("Response for : \(urlRequest)" + $0) }
                guard let httpResponse = response as? HTTPURLResponse,
                      200 ..< 300 ~= httpResponse.statusCode
                else {
                    throw DataError.unknown
                }
                return data
            }
            .mapError { error in
                if let error = error as? DataError {
                    return error
                } else {
                    return DataError.serverError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}

protocol ApiService {
    func request<T: Decodable>(router: URLRequestConvertible) -> AnyPublisher<T, DataError>
}

extension APIClient: ApiService {
    func request<T: Decodable>(router: URLRequestConvertible) -> AnyPublisher<T, DataError> {
        guard Reachability.isConnectedToNetwork() else {
            return Fail(error: DataError.notConnected)
                .eraseToAnyPublisher()
        }

        let urlRequest = try? router.urlRequest()
        return execute(request: urlRequest)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? DataError {
                    return error
                } else {
                    return DataError.serverError(error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
