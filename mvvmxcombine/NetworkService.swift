import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    var user: User?
    
    private init() { }
    
    func login(credentials: Credentials, completion: @escaping (Bool) -> Void) {
        // Waits 2 seconds to make time like a real network connection would take.
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in 
            if credentials.email.elementsEqual("test@mail.com") && credentials.password.elementsEqual("pass") {
                self?.user = User(firstName: "John", lastName: "AppleSeed")
                completion(true)
            } else {
                self?.user = nil
                completion(false)
            }
        }
    }
    
    func getUser() -> User? {
        return self.user
    }
}
