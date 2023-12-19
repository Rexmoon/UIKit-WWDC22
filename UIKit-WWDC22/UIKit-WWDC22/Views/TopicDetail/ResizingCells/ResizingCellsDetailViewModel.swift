//
//  ResizingCellsDetailViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/24/23.
//

import Combine
import UIKit

protocol ResizingCellsDetailViewModelRepresentable {
    var topic: Topic { get }
    var textPassthroughSubject: PassthroughSubject<[Resizing], Never> { get }
    
    func loadData()
    func didTapCollapsed(at: IndexPath)
}

final class ResizingCellsDetailViewModel {
    
    private var resizings: [Resizing] = [] {
        didSet {
            textPassthroughSubject.send(resizings)
        }
    }
    
    var topic: Topic
    var textPassthroughSubject = PassthroughSubject<[Resizing], Never>()
    
    init(topic: Topic) {
        self.topic = topic
    }
}

extension ResizingCellsDetailViewModel: ResizingCellsDetailViewModelRepresentable {
    
    func loadData() {
        
        (0...15).forEach { index in
            resizings.append(Resizing(collapsedText: "\(index): I am a collapsed Text...",
                                      expandedText: """
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                        \(index): I am a expanded Text...
                                                    """,
                                      expanded: false))
        }
    }
    
    func didTapCollapsed(at: IndexPath) {
        resizings[at.row].expanded.toggle()
    }
}
