import Combine
protocol PlayListServiceType {
    func getPlayList<T: Decodable>(id ID: String) -> AnyPublisher<T, DataError>
}
class PlayListService: PlayListServiceType {
    private let apiClient: ApiService
    
    // we can have them in configuration files yo have different id and secret for different enviorments
    // Also we can have authentication class which can add these secret and id in all request needing them
    private let clientID = "i71BoBoxTxlbVYvnt7O2reL86DynpqT3"
    private let clientSecret = "Mh6G90LOOuz1Vd04gBsNQMmHFwocWUzk"
    
    init(apiClient: ApiService = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getPlayList<T: Decodable>(id ID: String) -> AnyPublisher<T, DataError> {
        let route = Endpoint(route: Route.getPlayList, method: .get, path: [ID], queryItems: ["client_id": clientID, "client_secret": clientSecret])
        return apiClient.request(router: route)
    }
}
