import Foundation

final class HomeViewModel {
    
    @Published var message: String? = ""
    
    func getCurrentUser() {
        guard let user = NetworkService.shared.getUser() else { return }
        self.message = "\(user.firstName) \(user.lastName)"
    }
}
