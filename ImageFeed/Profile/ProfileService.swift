
import Foundation

struct ProfileResult: Codable {
    let username: String
    let first_name: String
    let last_name: String
    let bio: String?
    
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
}

final class ProfileService {
    
    static let shared = ProfileService()
    
    private init() {}
    
    private(set) var profile: Profile?
    private var task: URLSessionTask?
    private var lastToken: String?

    
    private func createURLRequest(authToken: String) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/\(authToken)") else {
            print("Ошибка при создании URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        if let task {
            task.cancel()
        }
        guard let request = createURLRequest(authToken: token) else {
            return
        }
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                let profile = Profile(
                    username: data.username,
                    name: "\(data.first_name) \(data.last_name)",
                    loginName: "@\(data.username)",
                    bio: data.bio
                )
                self.profile = profile
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
