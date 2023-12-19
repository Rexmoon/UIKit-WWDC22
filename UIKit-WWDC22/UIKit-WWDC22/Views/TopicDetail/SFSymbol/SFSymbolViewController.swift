//
//  SFSymbolViewController.swift
//  UIKit-WWDC22
//
//  Created by User on 12/19/23.
//

import UIKit

final class SFSymbolViewController: UIViewController {
    
    private let topic: Topic
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "wifi", variableValue: 0)
        return imageView
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderDidValueChaged(_:)), for: .valueChanged)
        return slider
    }()
    
    init(topic: Topic) {
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
        
        view.addSubview(image)
        view.addSubview(slider)
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0.75),
            image.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0.75),
            image.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0.90),
            image.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0.90),
            
            slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset * 3),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
        ])
    }
    
    @objc
    private func sliderDidValueChaged(_ slider: UISlider) {
        image.image = UIImage(
            systemName: "wifi",
            variableValue: Double(slider.value),
            configuration: UIImage.SymbolConfiguration(paletteColors: [.blue])
        )
    }
}
