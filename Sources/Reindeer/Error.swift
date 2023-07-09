//
//  Element+XPath.swift
//  Reindeer
//
//  Created by Eldho on 09/07/23.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import libxml2

enum InternalError: Error {
    
    case unknown
    case parse(message: String, code: Int)
    
    static func lastError() -> InternalError {
        guard let pointer = xmlGetLastError() else {
            return .unknown
        }
        
        let message = pointer.pointee.message.toString() ?? String.empty()
        let code = Int(pointer.pointee.code)
        
        return .parse(message: message, code: code)
    }
}
