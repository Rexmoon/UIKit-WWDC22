//
//  ResizingCellsDetailViewController.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/26/23.
//

import UIKit
import Combine

final class ResizingCellsDetailViewController<ViewModel: ResizingCellsDetailViewModelRepresentable>: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Resizing>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Resizing>
    
    private let viewModel: ViewModel
    
    private var subscriber: AnyCancellable?
    
    private lazy var dataSource: DataSource = {
        let configuration = UICollectionView.CellRegistration<UICollectionViewListCell, Resizing> { cell, indexPath, resizing in
            var configuration = cell.defaultContentConfiguration()
            
            configuration.text = resizing.expanded ? resizing.expandedText : resizing.collapsedText
            configuration.image = resizing.expanded ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
            
            cell.contentConfiguration = configuration
        }
        
        return DataSource(collectionView: collectionView) { collectionView, indexPath, text in
            collectionView.dequeueConfiguredReusableCell(using: configuration, for: indexPath, item: text)
        }
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: Self.generateLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private static func generateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func setupUI() {
        title = viewModel.topic.name
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        ///You can add the UI configuration to our collectionview here
        ///collectionView.selfSizingInvalidation = .enabledIncludingConstraints
    }
    
    private func bindUI() {
        subscriber = viewModel.textPassthroughSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { self.applySnapshot(with: $0) })
        
        viewModel.loadData()
    }
    
    private func applySnapshot(with: [Resizing]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(Section.allCases)
        
        Section.allCases.forEach { snapshot.appendItems(with, toSection: $0) }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapCollapsed(at: indexPath)
    }
}
