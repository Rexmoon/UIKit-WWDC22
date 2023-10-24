//
//  TopicDetailPageControlViewController.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna on 10/20/23.
//

import UIKit

final class TopicDetailPageControlViewController<ViewModel: TopicDetailPageControlViewModelRepresentable>: UIViewController, UIScrollViewDelegate {
    
    private let viewModel: ViewModel
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.direction = .leftToRight
        pageControl.preferredIndicatorImage = UIImage(systemName: "star")
        pageControl.pageIndicatorTintColor = .blue
        pageControl.preferredCurrentPageIndicatorImage = UIImage(systemName: "star.fill")
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .touchUpInside)
        return pageControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .gray
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var pageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var colors: [UIColor] = {
        [.red, .blue, .yellow]
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
    }
    
    private func setupUI() {
        title = viewModel.topic.name
        view.backgroundColor = .white
        
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        
        
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            scrollView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.8),
            scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10),
        ])
        
        scrollView.contentSize = CGSize(width: (view.bounds.width * 0.9) * 3, height: view.bounds.height * 0.8)
        
        for index in 0..<3 {
            let view = UIView(frame: CGRect(x: index * Int(view.bounds.width * 0.9),
                                                   y: 0,
                                                   width: Int(view.bounds.width * 0.9),
                                                   height: Int(view.bounds.height * 0.8)))
            view.backgroundColor = colors[index]
            scrollView.addSubview(view)
        }
    }
    
    @objc
    private func pageControlDidChange(_ sender: UIPageControl) {
        scrollView.setContentOffset(CGPoint(x: Double(sender.currentPage) * scrollView.frame.width,
                                            y: 0),
                                    animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 0 {
            let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = index
        }
        
        if scrollView.contentOffset.y < 0 || scrollView.contentOffset.y > 0 {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x,
                                               y: 0)
        }
    }
}
