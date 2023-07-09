//
//  Utils.swift
//  
//
//  Created by Eldho on 09/07/23.
//

import Foundation

class Utils {

  static func load(fileName: String, ext: String) -> Data {
    let bundle = Bundle(for: self)
      guard let path = bundle.path(forResource: fileName, ofType: ext) else {
          return Data()
      }
      return (try? Data(contentsOf: URL(fileURLWithPath: path))) ?? Data()
  }
}
