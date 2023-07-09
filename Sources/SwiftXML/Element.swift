//
//  Element.swift
//  SwiftXML
//
//  Created by Eldho on 09/07/23.
//  Copyright © 2020. All rights reserved.
//
import Foundation
import libxml2

open class Element: Equatable {
    
    let cNode: xmlNodePtr
    
    // MARK: - Initialization
    
    public init(node: xmlNodePtr) {
        self.cNode = node
    }
    
    // MARK: - Info
    
    public lazy var ns: String? = {
        return self.cNode.pointee.ns != nil ? self.cNode.pointee.ns.toString() : nil
    }()
    
    public lazy var prefix: String? = {
        return self.cNode.pointee.ns != nil ? self.cNode.pointee.ns.pointee.prefix.toString() : nil
    }()
    
    public lazy var name: String? = {
        return self.cNode.pointee.name != nil ? self.cNode.pointee.name.toString() : nil
    }()
    
    public lazy var line: Int? = {
        return xmlGetLineNo(self.cNode)
    }()
    
    public lazy var parent: Element? = {
        guard let cParent = self.cNode.pointee.parent else {
            return nil
        }
        return Element(node: cParent)
    }()
    
    public lazy var content: String? = {
        return xmlNodeGetContent(self.cNode).toString()
    }()
    
    public lazy var nextSibling: Element? = {
        guard let cSibling = self.cNode.pointee.next else {
            return nil
        }
        return Element(node: cSibling)
    }()
    
    public lazy var previousSibling: Element? = {
        guard let cSibling = self.cNode.pointee.prev else {
            return nil
        }
        return Element(node: cSibling)
    }()
    
    public lazy var attributes: [String: String] = {
        var dict: [String: String] = [:]
        
        var property = self.cNode.pointee.properties
        while property != nil {
            if let property = property, let name = property.pointee.name.toString() {
                let value = xmlGetProp(self.cNode, property.pointee.name).toString()
                dict[name] = value
            }
            
            property = property?.pointee.next
        }
        
        return dict
    }()
}

public func == (left: Element, right: Element) -> Bool {
    return left.cNode == right.cNode
}
