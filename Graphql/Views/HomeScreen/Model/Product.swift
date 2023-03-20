//
//  Product.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let description: String
    let price: Int
}
