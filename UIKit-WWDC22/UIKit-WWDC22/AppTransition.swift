//
//  AppTransition.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

enum AppTransition {
    case showTopicList
    
    var identifier: String { String(describing: self) }
    
    var hasState: Bool { false }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        switch self {
            case .showTopicList: return TopicListCoordinator(router: router)
        }
    }
}

extension AppTransition: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
