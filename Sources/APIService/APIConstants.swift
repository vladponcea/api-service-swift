//
//  APIConstants.swift
//  
//
//  Created by Vladut Mihai Poncea on 20.04.2023.
//

import Foundation

public class APIConstants {    
    public var baseURL: String
    public var apiKey: String
    
    init(
        baseURL: String,
        apiKey: String
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}
