//
//  PhotosWebSerivce.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

extension Webservice {
    enum QuerryStrings: GenericRouterEnum {
        case params(rover: String, earthDate: String)
        var method: HTTPMethod {
            switch self {
            case .params( _):
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .params(let rover,let earthDate):
                return "\(rover)/photos=\(earthDate)"
            }
        }
        var parameters: Parameters? {
            switch self {
            case .params(_, _):
                return nil
            }
        }
        
        var body: Parameters? {
            switch self {
            case .params(_ , _):
                return nil
            }
        }
    }
}

extension Webservice {
    
    enum GetPhotos { }
    
}

extension Webservice.GetPhotos {
    
    static func getMarsPhotos(rover: String, earthDate: String) -> Promise<[Photo]> {
        return Promise.init { seal in
            
            
            let request = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(earthDate)&api_key=DEMO_KEY"
            print(request)
            Alamofire.request(request, method: .get).responseJSON(completionHandler: { (response) in
                
                guard let statusCode = response.response?.statusCode else {
                    let error = NSError(domain: "Photos", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao obter status da resposta com o servidor"])
                    seal.reject(error)
                    return
                }
                
                switch statusCode {
                case 200, 201:
                    do {
                        let parsedResult = try
                            CodableParser<PhotosModel>.parse(dict: response.result.value)
                        seal.fulfill(parsedResult.photos!)
                    }
                    catch let error {
                        seal.reject(error)
                    }
                case 400:
                    let json = JSON(response.result.value ?? [:])
                    let errors = json.dictionary?.compactMap({ (key, value) -> NSError? in
                        let message = value.arrayValue.map({ $0.stringValue }).joined(separator: ", ")
                        return NSError(domain: "Photos", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(key.capitalized): \(message)"])
                    })
                    seal.reject(errors?.first ?? NSError(domain: "", code: -1, userInfo: [:]))
                default:
                    let error = NSError(domain: "Photos", code: -1, userInfo: [NSLocalizedDescriptionKey: response.error?.localizedDescription ?? ""])
                    seal.reject(error)
                }
            })
        }
    }
}
