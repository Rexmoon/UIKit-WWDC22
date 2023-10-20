//
//  HomeListCollectionViewController.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/19/23.
//

import UIKit
import Combine

enum Section: CaseIterable {
    case main
}

final class TopicListCollectionViewController<ViewModel: TopicListViewModelRepresentable>: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Topic>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Topic>
    
    private let viewModel: ViewModel
    
    private var subscriber: AnyCancellable?
    
    private lazy var dataSource: DataSource = {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Topic> { cell, indexPath, item in
            
            var configuration = cell.defaultContentConfiguration()
            
            configuration.text = item.name
            configuration.image = UIImage(systemName: "book")
            
            cell.contentConfiguration = configuration
            cell.accessories = [.disclosureIndicator()]
        }
        
        return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: Self.generateLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private static func generateLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout.list(using: UICollectionLayoutListConfiguration(appearance: .grouped))
    }
    
    private func setupUI() {
        title = "What's new in UIKit - WWDC22"
    }
    
    private func bindUI() {
        viewModel.loadData()
        
        let completion = { (completion: Subscribers.Completion<Error>) -> Void in
            switch completion {
                case .finished: print(completion)
                case .failure(let failure): fatalError(failure.localizedDescription)
            }
        }
        
        let receiveValue = { [unowned self] (topics: [Topic]) -> Void in
            applySnapshot(with: topics)
        }
        
        subscriber = viewModel.topicsValueSubject
            .sink(receiveCompletion: completion, receiveValue: receiveValue)
    }
    
    private func applySnapshot(with: [Topic]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(with)
        
        dataSource.apply(snapshot, animatingDifferences: true) { [unowned self] in
            collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didTapItem(with: indexPath)
    }
}
