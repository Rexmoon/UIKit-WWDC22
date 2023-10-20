//
//  Topic.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

import Foundation

struct Topic {
    let id = UUID()
    let name: String
    let description: String
}

extension Topic: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
