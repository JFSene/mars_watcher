//
//  RequestAdapter.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation
import Alamofire

class GenericRequestAdapter: RequestAdapter {
    
    let tokenType = "Bearer"
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let token = UserDefaults.standard.accessToken, !token.isEmpty {
            urlRequest.setValue(tokenType + " " + token, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
    
}
