//
//  ApiService.swift
//  SwiftUIContactMVVM
//
//  Created by Abduqaxxor on 30/1/23.
//

import Foundation
import Combine

public struct HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
    static let del = "DELETE"
}


final class ApiService {
    static var shared = ApiService()
    private var task: URLSessionTask?
    
    public func get<T: Decodable>(endpoint: EndPointType, objectType: T.Type) -> AnyPublisher<T, Error> {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseUrl
        components.path = endpoint.path
        let url = components.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        if request.httpMethod == HTTPMethod.post || request.httpMethod == HTTPMethod.put {
            request.httpBody = endpoint.body
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ response in
                print("********************************")
                print("URL: \(request.url!.absoluteString)")
                if let body = request.httpBody {
                    print("BODY: \(String(data: body, encoding: .utf8) ?? "")")
                }
                print("RESPONSE: \(response.data.prettyPrintedJSONString ?? "")")
                print("********************************")
                
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
