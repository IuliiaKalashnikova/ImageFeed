
import Foundation
struct UserResult: Codable {
    let profile_image: ProfileImage
}

 struct ProfileImage: Codable {
    let small: String
}

final class ProfileImageService {
    
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private(set) var avatarUrl: String?
    
    private init() {}
    
    func fetchProfileImageURL(username: String, token: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        
        if let task {
            task.cancel()
        }
        
        guard let request = createURLRequest(username: username) else {
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                let profileImageURL = data.profile_image.small
                self.avatarUrl = profileImageURL
                
                completion(.success(profileImageURL))
                
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: ["URL": profileImageURL]
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func createURLRequest(username: String) -> URLRequest? {
        
         
        guard let url = URL(string: "https://api.unsplash.com/\(username)") else {
            print("Ошибка при создании URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(username)", forHTTPHeaderField: "Authorization")
        return request
     }
    
}
