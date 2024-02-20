//
//  Topic.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

import Foundation
import UIKit

enum TopicImage: CaseIterable {
    case pageControl
    case resizingCell
    case withSwiftUI
    case customizingSheet
    case sfSymbol
    
    var image: UIImage? {
        switch self {
            case .pageControl: return UIImage(systemName: "book.pages")
            case .resizingCell: return UIImage(systemName: "tablecells")
            case .withSwiftUI: return UIImage(systemName: "cube")
            case .customizingSheet: return UIImage(systemName: "book.pages")
            case .sfSymbol: return UIImage(systemName: "applepencil")
        }
    }
}

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
