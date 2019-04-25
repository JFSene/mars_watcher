//
//  GenericRequestRetrier.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation
import Alamofire

class GenericRequestRetrier: RequestRetrier {
    
    private typealias RefreshCompletion = (_ success: Bool, _ accessToken: String?) -> Void
    
    private let loginStoryboardName = "SignIn"
    private let refreshTokenEndpoint = "auth/refresh/"
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] (success, accessToken) in
                    guard let strongSelf = self else { return }
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    guard success else {
                        strongSelf.presentLoginScreen()
                        completion(false, 0.0)
                        return
                    }
                    
                    UserDefaults.standard.accessToken = accessToken
                    strongSelf.requestsToRetry.forEach({ $0(success, 0.0) })
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        }
        else {
            completion(false, 0.0)
        }
    }
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        
        let urlString = Webservice.baseDomain + Webservice.apiEndpoint 
        guard let refreshURL = URL(string: urlString) else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.refreshToken ?? "")"
        ]
        
        request(refreshURL, method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers)
            .responseJSON { [weak self] response in
                if let json = response.result.value as? [String: Any], let accessToken = json["access"] as? String {
                    completion(true, accessToken)
                }
                else {
                    completion(false, nil)
                }
                self?.isRefreshing = false
        }
    }
    
    // Login presenter
    private func presentLoginScreen() {
        guard Bundle.main.url(forResource: loginStoryboardName, withExtension: "storyboardc") != nil else {
            fatalError("The login storyboard is either missing or with an incorrect name. You should correct this at the AppfyRequestRetrier class.")
        }
        
        let sb = UIStoryboard(name: loginStoryboardName, bundle: nil)
        guard let loginVC = sb.instantiateInitialViewController() else { return }
        guard let topController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        topController.present(loginVC, animated: true, completion: nil)
    }
    
}
