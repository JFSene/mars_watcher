//
//  GenericRouterEnum.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation
import Alamofire

protocol GenericRouterEnum: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var body: Parameters? { get }
}

extension GenericRouterEnum {
    
    func asURLRequest() throws -> URLRequest {
        let url = try (Webservice.baseDomain + Webservice.apiEndpoint).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let param = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: param)
        }
        
        if let safeBody = body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: safeBody, options: [])
        }
        
        return urlRequest
    }
    
}
