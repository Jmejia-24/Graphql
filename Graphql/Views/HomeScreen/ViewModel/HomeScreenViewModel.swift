//
//  HomeScreenViewModel.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import UIKit
import Combine

protocol HomeScreenViewModelRepresentable: ObservableObject {
    func fechProductList()
    var products: [Product] { get }
}

final class HomeScreenViewModel<R: AppRouter> {
    var router: R?
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var products = [Product]()
}

extension HomeScreenViewModel: HomeScreenViewModelRepresentable {
    func fechProductList() {
        let recieved = { (response: [Product]) -> Void in
            DispatchQueue.main.async { [unowned self] in
                products = response
            }
        }
        
        let completion = { (completion: Subscribers.Completion<GraphQLError>) -> Void in
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        APIManager.shared.performOperation(.productList)
            .sink(receiveCompletion: completion, receiveValue: recieved)
            .store(in: &cancellables)
    }
}
