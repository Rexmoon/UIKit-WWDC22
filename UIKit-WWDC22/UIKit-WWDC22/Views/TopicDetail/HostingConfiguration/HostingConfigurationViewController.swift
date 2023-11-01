//
//  HostingConfigurationViewController.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/28/23.
//

import UIKit
import Combine
import SwiftUI

final class HostingConfigurationViewController<ViewModel: HostingConfigurationViewModelRepresentable>: UIViewController {
    
    typealias TableViewDatasource = UITableViewDiffableDataSource<Section, HostingConfiguration>
    typealias TableViewSnapshot = NSDiffableDataSourceSnapshot<Section, HostingConfiguration>
    
    typealias CollectionViewDatasource = UICollectionViewDiffableDataSource<Section, HostingConfiguration>
    typealias CollectionViewSnapshot = NSDiffableDataSourceSnapshot<Section, HostingConfiguration>
    
    private let viewModel: ViewModel
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
        return tableView
    }()
    
    private lazy var tableViewDatasource: TableViewDatasource = {
        
        let dataSource = TableViewDatasource(tableView: tableView) { tableView, indexPath, hostingConfiguration in
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier,
                                                     for: indexPath) as? ReusableTableViewCell
            else {
                fatalError()
            }
            
            cell.contentConfiguration = UIHostingConfiguration {
                SwiftUIView(hostingConfiguration: hostingConfiguration)
            }
            
            return cell
        }
        
        return dataSource
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                              collectionViewLayout: Self.generateLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    private lazy var collectionViewDatasource: CollectionViewDatasource = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HostingConfiguration> { cell, indexPath, hostingConfiguration in
            cell.contentConfiguration = UIHostingConfiguration {
                SwiftUIView(hostingConfiguration: hostingConfiguration)
            }
        }
        
        return CollectionViewDatasource(collectionView: collectionView) { collectionView, indexPath, hostingConfiguration in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: hostingConfiguration)
        }
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        
        title = viewModel.topic.name
        
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -inset),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0.5),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -inset),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ReusableTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: ReusableTableViewCell.identifier)
    }
    
    private static func generateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func bindUI() {
        viewModel.tableViewEntitiesPassthroughSubject
            .receive(on: DispatchSerialQueue.main)
            .sink(receiveValue: {
                self.applyTableViewSnapshot(with: $0)
            })
            .store(in: &cancellables)
        
        viewModel.collectionViewEntitiesPassthroughSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.applyCollectionViewSnapshot(with: $0)
            })
            .store(in: &cancellables)
        
        viewModel.loadData()
    }
    
    private func applyTableViewSnapshot(with: [HostingConfiguration]) {
        var snapshot = TableViewSnapshot()
        
        snapshot.appendSections(Section.allCases)
        
        Section.allCases.forEach { snapshot.appendItems(with, toSection: $0) }
        
        tableViewDatasource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyCollectionViewSnapshot(with: [HostingConfiguration]) {
        var snapshot = CollectionViewSnapshot()
        
        snapshot.appendSections(Section.allCases)
        
        Section.allCases.forEach { snapshot.appendItems(with, toSection: $0) }
        
        collectionViewDatasource.apply(snapshot, animatingDifferences: true)
    }
}
