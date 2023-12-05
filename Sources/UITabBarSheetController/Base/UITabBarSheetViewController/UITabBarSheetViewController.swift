//
//  UITabBarSheetViewController.swift
//
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

class UITabBarSheetViewController: UIViewController {
    // MARK: - Private Properties
    private var visualEffectView: UIVisualEffectView!
    
    // MARK: - Internal Properties
    private(set) var viewController: UIViewController? = nil
    
    // MARK: - init(nibName:bundle:)
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setupVisualEffectView()
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupVisualEffectView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: .systemMaterial)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.perform(Selector(("_setGroupName:")), with: "Backdrop Group")
        
        view.addSubview(visualEffectView)
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bringTabBarToFrontInWindow() {
        let tabBar = view.window?.subviews.first { $0 is UITabBar }
        guard let tabBar = tabBar as? UITabBar else { return }
        view.window?.bringSubviewToFront(tabBar)
    }
    
    private func layoutViewControllerView() {
        viewController?.view.frame = view.frame
    }
    
    // MARK: - Public Methods
    func setViewController(_ viewController: UIViewController?) {
        if let previousViewController = self.viewController {
            previousViewController.willMove(toParent: nil)
            previousViewController.view.removeFromSuperview()
            previousViewController.removeFromParent()
        }
        
        if let viewController {
            addChild(viewController)
            viewController.view.frame = view.frame
            view.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
        
        self.viewController = viewController
    }
    
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bringTabBarToFrontInWindow()
        layoutViewControllerView()
    }
}
