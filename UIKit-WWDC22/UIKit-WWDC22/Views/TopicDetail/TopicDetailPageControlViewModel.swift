//
//  TopicDetailPageControlViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

protocol TopicDetailPageControlViewModelRepresentable {
    
    var topic: Topic { get }
}

final class TopicDetailPageControlViewModel {
    
    var topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
    }
}

extension TopicDetailPageControlViewModel: TopicDetailPageControlViewModelRepresentable { }
