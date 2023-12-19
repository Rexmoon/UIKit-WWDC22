//
//  Resizing.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/26/23.
//

import Foundation

struct Resizing {
    let id: UUID = .init()
    let collapsedText: String
    let expandedText: String
    
    var expanded: Bool
}

extension Resizing: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
