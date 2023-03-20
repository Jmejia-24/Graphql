//
//  HomeScreenViewModel.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

import UIKit

protocol HomeScreenViewModelRepresentable {
}

final class HomeScreenViewModel<R: AppRouter> {
    var router: R?
}

extension HomeScreenViewModel: HomeScreenViewModelRepresentable {
}
