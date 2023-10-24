//
//  TopicTransition.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

enum TopicTransition {
    
    case showPageControlDetail(Topic)
    
    var identifier: String { String(describing: self) }
}
