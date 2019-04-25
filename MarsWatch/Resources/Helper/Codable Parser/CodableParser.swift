//
//  CodableParser.swift
//  MarsWatch
//
//  Created by BRQ on 25/04/19.
//  Copyright © 2019 BarbaRuiva. All rights reserved.
//

import Foundation

class CodableParser<T: Codable> {
    static func parse(dict: Any?) throws -> T {
        guard let safeDict = dict as? [String: Any] else {
            throw NSError(domain: "CodableParser", code: -1, userInfo: [NSLocalizedDescriptionKey: "Can't parse nil dictionary"])
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: safeDict, options: .prettyPrinted)
            let value = try JSONDecoder().decode(T.self, from: jsonData)
            return value
        }
        catch let error {
            throw error
        }
    }
    
    static func parse(list: Any?) throws -> [T] {
        guard let safeList = list as? [[String: Any]] else {
            throw NSError(domain: "CodableParser", code: -1, userInfo: [NSLocalizedDescriptionKey: "Can't parse nil list"])
        }
        return try safeList.compactMap({
            do {
                return try CodableParser.parse(dict: $0)
            }
            catch let error {
                throw error
            }
        })
    }
}
