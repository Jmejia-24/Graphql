//
//  APIManager.swift
//  Graphql
//
//  Created by Byron Mejia on 3/20/23.
//

import UIKit
import Combine

final class APIManager {
    static let shared = APIManager()
    
    /// Performs the desired GraphQLOperation
    /// - Parameters:
    ///   - operation: The GraphQLOperation to perform
    ///   - completion: A completion handler that will be called on a background thread
    ///                 with a Result containing either a decoded object of type T, or an Error
    func performOperation<T: Decodable>(_ operation: GraphQLOperation) -> Future<T, GraphQLError> where T : Codable {
        return Future { promise in
            let request: URLRequest
            
            do {
                try request = operation.getURLRequest()
            } catch {
                promise(.failure(.encodingError(error)))
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    promise(.failure(.noData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GraphQLResult<T>.self, from: data)
                    if let object = result.object {
                        promise(.success(object))
                    } else {
                        NSLog(result.errorMessages.joined(separator: "\n"))
                        promise(.failure(.backendMessages(result.errorMessages)))
                    }
                }
                catch {
                    promise(.failure(.decodingError(error)))
                }
            }
            task.resume()
        }
    }
}
