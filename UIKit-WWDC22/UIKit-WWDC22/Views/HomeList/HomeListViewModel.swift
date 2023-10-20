//
//  HomeListViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

protocol HomeListViewModelRepresentable {
    func loadData()
}

final class HomeListViewModel<R: AppRouter> {
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension HomeListViewModel: HomeListViewModelRepresentable {
    func loadData() {
        
    }
}
