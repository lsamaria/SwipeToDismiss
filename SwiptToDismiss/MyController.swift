//
//  MyController.swift
//  SwiptToDismiss
//
//  Created by Lance Samaria on 11/15/19.
//  Copyright © 2019 Lance Samaria. All rights reserved.
//

import UIKit

class MyController: UIViewController {
    
    
    // MARK:- UIElements
    fileprivate lazy var cancelButto: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var directionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Swipe in any direction to dismiss"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK:- Properties
    fileprivate var cancelButton: UIBarButtonItem?
    
    // MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setNavigationAppearance()
        
        setNavigationDelegates()
        
        configureAnchors()
        
        configureGestures()
    }
    
    // MARK:- Navigation Apperance
    fileprivate func setNavigationAppearance() {
        
        navigationItem.title = "My Controller"
        
        cancelButton = UIBarButtonItem(customView: cancelButto)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // MARK:- Target Actions
    @objc fileprivate func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Anchors
    fileprivate func configureAnchors() {
        
        view.addSubview(directionsLabel)
        
        directionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        directionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        directionsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

// MARK:- UINavigationControllerDelegate
extension MyController: UINavigationControllerDelegate {
    
    fileprivate func setNavigationDelegates() {
        
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK:- Gestures
extension MyController {
    
    fileprivate func configureGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
}

// MARK:- UIGestureRecognizerDelegate
extension MyController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer){

        let interactiveTransition = UIPercentDrivenInteractiveTransition()

        let percent = max(gesture.translation(in: view).x, 0) / view.frame.width

        switch gesture.state {

        case .began:
            navigationController?.dismiss(animated: true, completion: nil)

        case .changed:
            interactiveTransition.update(percent)

        case .ended:
            let velocity = gesture.velocity(in: view).x

            // Continue if drag more than 50% of screen width or velocity is higher than 1000
            if percent > 0.5 || velocity > 1000 {
                interactiveTransition.finish()
            } else {
                interactiveTransition.cancel()
            }

        case .cancelled, .failed:
            interactiveTransition.cancel()

        default:break
        }
    }
}
