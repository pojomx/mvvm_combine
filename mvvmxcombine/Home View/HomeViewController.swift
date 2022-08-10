import Combine
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var otherLabel: UILabel!
    
    var cancellables: Set<AnyCancellable> = []
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        viewModel.getCurrentUser()
    }
    
    private func setupBinders() {
        viewModel
            .$message
            .map { message in "Hello \(message)"}
            .sink { [weak self] message in
                self?.welcomeLabel.text = message
            }.store(in: &cancellables)
        
        viewModel
            .$message
            .map { message in "User: \(message)"}
            .assign(to: \.text, on: otherLabel)
            .store(in: &cancellables)
    }
    
    
}
