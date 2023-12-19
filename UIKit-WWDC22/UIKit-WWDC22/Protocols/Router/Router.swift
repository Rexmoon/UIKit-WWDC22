//
//  Router.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit

protocol Router {
    
    associatedtype Route
    
    var navController: UINavigationController { get set }
    
    func process(route: Route)
    func exit()
}

protocol AppRouter: Router where Route == AppTransition { }

protocol TopicRouter: Router where Route == TopicTransition { }

protocol CustomizingSheetRouter: Router where Route == CustomizingSheetTransition { }
