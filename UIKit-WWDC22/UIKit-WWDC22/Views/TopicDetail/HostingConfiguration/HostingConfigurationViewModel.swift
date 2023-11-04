//
//  HostingConfigurationViewModel.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/28/23.
//

import Combine

protocol HostingConfigurationViewModelRepresentable {
    var topic: Topic { get }
    var tableViewEntitiesPassthroughSubject: PassthroughSubject<[HostingConfiguration], Never> { get }
    var collectionViewEntitiesPassthroughSubject: PassthroughSubject<[HostingConfiguration], Never> { get }
    
    func loadData()
}

final class HostingConfigurationViewModel {
    
    private var tableViewEntities: [HostingConfiguration] = [] {
        didSet {
            tableViewEntitiesPassthroughSubject.send(tableViewEntities)
        }
    }
    
    private var collectionViewEntities: [HostingConfiguration] = [] {
        didSet {
            collectionViewEntitiesPassthroughSubject.send(collectionViewEntities)
        }
    }
    
    var topic: Topic
    var tableViewEntitiesPassthroughSubject: PassthroughSubject<[HostingConfiguration], Never> = .init()
    var collectionViewEntitiesPassthroughSubject: PassthroughSubject<[HostingConfiguration], Never> = .init()
    
    init(topic: Topic) {
        self.topic = topic
    }
}

extension HostingConfigurationViewModel: HostingConfigurationViewModelRepresentable {
    func loadData() {
        (0...10).forEach {
            tableViewEntities.append(HostingConfiguration(text: "\($0)", type: .forTableView))
        }
        
        (0...10).forEach {
            collectionViewEntities.append(HostingConfiguration(text: "\($0)", type: .forCollectionView))
        }
    }
}
