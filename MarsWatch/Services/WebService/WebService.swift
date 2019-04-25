//
//  WebService.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation
import Alamofire

class Webservice: SessionManager {
    
    // Route base
    static let baseDomain = "https://api.nasa.gov/"
    static let apiEndpoint = "api/v1/rovers/"
    static let session = Webservice()
    
    static let acceptableStatusCodes: [Int] = {
        return (200...600).filter({ $0 != 401 })
    }()
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        self.init(configuration: configuration)
        self.adapter = GenericRequestAdapter()
        self.retrier = GenericRequestRetrier()
    }
    
    class func request(_ request: GenericRouterEnum, completion: @escaping (DataResponse<Any>) -> Void) {
        Webservice.session
            .request(request)
            .validate(statusCode: Webservice.acceptableStatusCodes)
            .responseJSON(completionHandler: completion)
    }
    
}
