//
//  GraphQLResult.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

/// A container for decoding the result of a GraphQL query or mutation
struct GraphQLResult<T: Decodable>: Decodable {
    
    /// The decoded object, if present
    let object: T?
    /// A list of error messages from the GraphQL server. There can be errors even if an object
    /// was successfully decoded.
    let errorMessages: [String]
    
    enum CodingKeys: String, CodingKey {
        case data
        case errors
    }
    
    struct Error: Decodable {
        let message: String
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dataDict = try container.decodeIfPresent([String: T].self, forKey: .data)
        self.object = dataDict?.values.first
        
        var errorMessages: [String] = []
        
        let errors = try container.decodeIfPresent([Error].self, forKey: .errors)
        if let errors = errors {
            errorMessages.append(contentsOf: errors.map { $0.message })
        }
        
        self.errorMessages = errorMessages
    }
}
