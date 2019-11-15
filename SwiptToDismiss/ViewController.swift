//
//  ViewController.swift
//  SwiptToDismiss
//
//  Created by Lance Samaria on 11/15/19.
//  Copyright © 2019 Lance Samaria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK:- UIElements
    fileprivate lazy var pressButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(pressButtonPressed), for: .touchUpInside)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setNavigationAppearance()
        
        configureAnchors()
    }
    
    // MARK:- Navigation Appearance
    fileprivate func setNavigationAppearance() {
        navigationItem.title = "Initial VC"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    // MARK:- Target Actions
    @objc fileprivate func pressButtonPressed() {
        let myVC = MyController()
        let navVC = UINavigationController(rootViewController: myVC)
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK:- Anchors
    fileprivate func configureAnchors() {
        
        view.addSubview(pressButton)
        
        pressButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pressButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pressButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        pressButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

