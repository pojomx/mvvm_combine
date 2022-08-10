import Foundation
import Combine

final class LoginViewModel {
    
    @Published var error: String?
    @Published var credentials: Credentials?
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBinders()
    }
    
    private func setupBinders() {
        $credentials
            .dropFirst() //When you sink something, it calls the callback... so ignore the first one.
            .sink { [weak self] credentials in
                guard let credentials = self?.credentials else { return }
                self?.executeLogin(credentials)
            }.store(in: &cancellables)
    }
    
    private func executeLogin(_ credentials: Credentials) {
        NetworkService.shared.login(credentials: credentials) { success in 
            self.error = success ? nil : "Invalid Credentials"
        }    
    }
    
    func validateCredentials(email: String?, password: String?) -> Credentials? {
        guard let email = email, 
                let password = password else { return nil }
        return Credentials(email: email, password: password)
    }
}
