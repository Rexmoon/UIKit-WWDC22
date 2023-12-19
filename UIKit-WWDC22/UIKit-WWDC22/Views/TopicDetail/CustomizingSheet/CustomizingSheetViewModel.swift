//
//  CustomizingSheetViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna 12/16/23.
//

import Foundation

protocol CustomizingSheetViewModelRepresentable {
    func showSheet(_ value: Float)
}

final class CustomizingSheetViewModel<R: CustomizingSheetRouter> {
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension CustomizingSheetViewModel: CustomizingSheetViewModelRepresentable {
    
    func showSheet(_ value: Float) {
        router.process(route: .showSheet(CGFloat(value)))
    }
}
