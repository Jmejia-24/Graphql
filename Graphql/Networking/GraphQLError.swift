//
//  GraphQLError.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

enum GraphQLError: LocalizedError {
    case noData
    case invalidData
    case noToken
    case unimplemented
    case backendMessages([String])
    case encodingError(Error)
    case decodingError(Error)
    
    var errorDescription: String? {
        let dataMessage = "Error with data"
        let unknown = "Unknown error"
        switch self {
        case .noData, .invalidData:
            return dataMessage
        case .noToken:
            return "Error with sign-in info"
        case .backendMessages:
            return "Server error"
        case .encodingError(let other), .decodingError(let other):
            return (other as? LocalizedError)?.errorDescription ?? dataMessage
        default:
            return unknown
        }
    }
    
    var recoverySuggestion: String? {
        "Try again a little later. Contact us if this happens repeatedly."
    }
}
