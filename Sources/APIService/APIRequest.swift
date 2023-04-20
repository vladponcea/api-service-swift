//
//  APIRequst.swift
//  
//
//  Created by Vladut Mihai Poncea on 20.04.2023.
//

import Foundation

public final class APIRequest {
    public let endpoint: String
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    private let constants: APIConstants
    
    private var urlString: String {
        var string = constants.baseURL + "/\(endpoint)"
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public var httpMethod = "GET"
    
    public init(
        constants: APIConstants,
        endpoint: String,
        pathComponents: [String],
        queryParameters: [URLQueryItem]
    ) {
        self.constants = constants
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
