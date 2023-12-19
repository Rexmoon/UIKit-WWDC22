//
//  CustomizingSheetViewController.swift
//  UIKit-WWDC22
//
//  Created by Bryan Luna 12/16/23.
//

import UIKit

final class CustomizingSheetViewController<ViewModel: CustomizingSheetViewModelRepresentable>: UIViewController {
    
    private let viewModel: ViewModel
    private let topic: Topic
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show sheet", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: ViewModel, topic: Topic) {
        self.viewModel = viewModel
        self.topic = topic
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = topic.name
        
        view.backgroundColor = .label
        
        view.addSubview(slider)
        view.addSubview(button)
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.heightAnchor.constraint(equalToConstant: inset * 3),
            button.widthAnchor.constraint(equalToConstant: inset * 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: inset),
        ])
    }
    
    @objc
    private func buttonClicked() {
        viewModel.showSheet(slider.value)
    }
}
