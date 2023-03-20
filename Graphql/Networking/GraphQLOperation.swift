//
//  GraphQLOperation.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import Foundation

enum GraphQLOperation {
    // Queries
    case productList
    
    // MARK: - Public
    
    /// Generates a URL request for the operation.
    /// Handles encoding the appropriate query or mutation string, as well as
    /// the variables which are stored in the associated data of each case
    func getURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(self)
        
        return request
    }
    
    // MARK: - Private
    
    private var url: URL {
        URL(string: "https://api-eu-central-1.hygraph.com/v2/ck8sn5tnf01gc01z89dbc7s0o/master")!
    }
    
    private var queryString: String {
        switch self {
        case .productList:
            return GraphQLQueries.products
        }
    }
}

// MARK: - Encoding

extension GraphQLOperation: Encodable {
    enum CodingKeys: String, CodingKey {
        case query
        case variables
        case input
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(queryString, forKey: .query)
        var variablesContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .variables)
        
        switch self {
        case .productList:
            try variablesContainer.encode(true, forKey: .input)
        }
    }
}

