//
//  File.swift
//  
//
//  Created by Eldho on 10/07/23.
//

import Foundation

public enum Resources: String {
    case test1 = "test1.xml"
    case test2 = "test2.xml"
    case test3 = "test3.html"
    case test4 = "test4.svg"

    var url: URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        return thisDirectory.appendingPathComponent("Resources/\(self.rawValue)")
    }

    func getData() throws -> Data {
        return try Data(contentsOf: self.url)
    }
}
