//
//  HostingConfiguration.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/28/23.
//

import Foundation
import UIKit

enum CellType: String {
    case forTableView
    case forCollectionView
    
    var image: UIImage? {
        switch self {
            case .forTableView: return UIImage(systemName: "square")
            case .forCollectionView: return UIImage(systemName: "sparkles")
        }
    }
}

struct HostingConfiguration {
    let id: UUID = .init()
    let text: String
    let type: CellType
}

extension HostingConfiguration: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
