//
//  HomeScreenCoordinator.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import UIKit
import SwiftUI

final class HomeScreenCoordinator<R: AppRouter> {
    let router: R
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = HomeScreenViewModel<R>()
        viewModel.router = router
        let viewController = UIHostingController(rootView: HomeScreenView(viewModel: viewModel))
        return viewController
    }()
    
    init(router: R) {
        self.router = router
    }
}

extension HomeScreenCoordinator: Coordinator {
    func start() {
        if router.navigationController.viewControllers.isEmpty {
            router.navigationController.pushViewController(primaryViewController, animated: true)
        } else {
            router.navigationController.viewControllers.removeAll()
            router.navigationController.pushViewController(primaryViewController, animated: true)
        }
    }
}
