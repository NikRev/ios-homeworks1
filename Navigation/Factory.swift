import UIKit

final class Factory {
    enum Flow {
        case first
        case second
        case third
    }

    private let flow: Flow
    var navigationController = UINavigationController()
    var coordinator:Coordinator?
    

    init(flow: Flow) {
        self.flow = flow
        self.navigationController = UINavigationController()
        self.coordinator = createCoordiantor()
        self.coordinator?.start()
    }
    
    func createCoordiantor()->Coordinator?{
        switch flow {
        case .first:
            return ProfileCoordinator(navigationController: navigationController)
        case .second:
            return FeedCoordinator(navigationController: navigationController)
        case .third:
            return LogInCoordinator(navigationController: navigationController)
        }
    }
   
    
}
