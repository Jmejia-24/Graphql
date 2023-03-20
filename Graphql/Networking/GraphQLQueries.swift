//
//  GraphQLQueries.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

enum GraphQLQueries {
    // MARK: - Queries
    
    static let products = """
        {
            products {
                \(QueryObjects.product)
            }
        }
    """
}
