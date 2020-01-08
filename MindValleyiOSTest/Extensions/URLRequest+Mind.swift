//
//  URLRequest+Mind.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import Foundation

extension URLRequest {
    private static let baseUrl = "https://pastebin.com"
    
    init(_ endpoint: APIEndpoint, _ method: APIMethod, _ parameters: [String: Any?]? = nil, _ urlArgs: CVarArg...) {
        let path = String(format: endpoint.rawValue, arguments: urlArgs)
        let urlString = URLRequest.urlResolver(for: endpoint, path: path)
        let url = URL(string: urlString)!
        self.init(url: url)
        self.httpMethod = method.rawValue
        processParameters(method, parameters)
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.timeoutInterval = 30
    }
    
    private static func urlResolver(for endPoint: APIEndpoint,
                                    path: String) -> String {
        let urlString = "\(URLRequest.baseUrl)\(path)"
        return urlString
    }
    
    private mutating func processParameters(_ method: APIMethod, _ parameters: [String: Any?]? = nil) {
        switch method {
        case .get:
            processGetParameters(parameters)
        default:
            processPostParameters(parameters)
        }
    }
    
    private mutating func processPostParameters(_ parameters: [String: Any?]? = nil) {
        if let parameters = parameters, let jsonParameters = try? JSONSerialization.data(withJSONObject: parameters,
                                                                                         options: []) {
            self.httpBody = jsonParameters
        }
    }
    
    private mutating func processGetParameters(_ parameters: [String: Any?]? = nil) {
        guard let parameters = parameters, !parameters.isEmpty else { return }
        let queryParameters = parameters.reduce("?") { (result, element) -> String in
            guard let value = element.value else { return result }
            if result.count > 1 {
                return "\(result)&\(element.key)=\(value)"
            }
            return "\(result)\(element.key)=\(value)"
        }
        var queryCharSet = NSCharacterSet.urlQueryAllowed
        queryCharSet.remove(charactersIn: "+")
        if let url = self.url?.absoluteString,
            let urlQueryParameters = queryParameters.addingPercentEncoding(withAllowedCharacters: queryCharSet) {
            let urlWithParameters = "\(url)\(urlQueryParameters)"
            self.url = URL(string: urlWithParameters)!
        }
    }
}

