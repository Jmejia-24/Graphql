//
//  HomeScreenView.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import SwiftUI
struct HomeScreenView<T>: View where T: HomeScreenViewModelRepresentable {
    @StateObject var viewModel: T
    
    var body: some View {
        List(viewModel.products) {
            Text($0.name)
        }
        .onAppear {
            viewModel.fechProductList()
        }
    }
}
