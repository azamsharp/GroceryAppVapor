//
//  HTTPClient.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                print(errorMessage)
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
    
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod = .get([])
    var modelType: T.Type
}

struct HTTPClient {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
            
            var request = URLRequest(url: resource.url)
            
            switch resource.method {
                case .post(let data):
                    request.httpMethod = resource.method.name
                    request.httpBody = data
                case .get(let queryItems):
                    var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                    components?.queryItems = queryItems
                    guard let url = components?.url else {
                        throw NetworkError.badRequest
                    }
                    request = URLRequest(url: url)
            }
            
            // create the URLSession configuration
            let configuration = URLSessionConfiguration.default
            // add default headers
            configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
            let session = URLSession(configuration: configuration)
            
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...201).contains(httpResponse.statusCode)
            else {
                throw NetworkError.invalidResponse
            }
            
        guard let result = try? JSONDecoder().decode(resource.modelType, from: data) else {
                throw NetworkError.decodingError
            }
            
            return result
        }
    
    func register(username: String, password: String) async throws -> Bool {
        
        let registerBody = ["username": username, "password": password]
        
        var request = URLRequest(url: Constants.Urls.register)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(registerBody)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        switch httpResponse.statusCode {
            case 200...201:
                return true
            case 409:
                throw NetworkError.serverError(Constants.Messages.usernameTaken)
            default:
                throw NetworkError.serverError(Constants.Messages.unknownError)
        }
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        
        let loginBody = ["username": username, "password": password]
        
        var request = URLRequest(url: Constants.Urls.login)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }
    
    func getGroceryCategoriesBy(userId: UUID) async throws -> [GroceryCategory] {
        
        let (data, response) = try await URLSession.shared.data(from: Constants.Urls.groceryCategoriesByUserId(userId: userId))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let groceryCategories = try? JSONDecoder().decode([GroceryCategory].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return groceryCategories
    }
 
    func createGroceryCategory(groceryCategoryRequest: GroceryCategoryRequest) async throws -> GroceryCategory {
        
        let defaults = UserDefaults.standard
        guard let userIdString = defaults.value(forKey: "userId") as? String,
              let userId = UUID(uuidString: userIdString)
        else {
            throw NetworkError.badRequest
        }
        
        var request = URLRequest(url: Constants.Urls.saveGroceryCategoryByUserId(userId: userId))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(groceryCategoryRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        switch httpResponse.statusCode {
            case 200...201:
                let savedGroceryCategory = try JSONDecoder().decode(GroceryCategory.self, from: data)
                return savedGroceryCategory
            case 409:
                throw NetworkError.serverError(Constants.Messages.groceryCategoryCreationError)
            default:
                throw NetworkError.serverError(Constants.Messages.unknownError)
        }
        
    }
    
}
