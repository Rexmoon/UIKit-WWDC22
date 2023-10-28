//
//  TopicDetailPageControlViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

protocol PageControlDetailViewModelRepresentable {
    
    var topic: Topic { get }
}

final class PageControlDetailViewModel {
    
    var topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
    }
}

extension PageControlDetailViewModel: PageControlDetailViewModelRepresentable { }
