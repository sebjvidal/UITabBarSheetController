//
//  UITabBarSheetController.swift
//
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

public class UITabBarSheetController: UIViewController, UITabBarDelegate {
    // MARK: - Private Properties
    private var dummyTabBarController: UITabBarController!
    private var customTabBar: UITabBar!
    
    // MARK: - Public Properties
    public var rootViewController: UIViewController? = nil {
        willSet {
            setRootViewController(newValue, removing: rootViewController)
        }
    }
    
    public var viewControllers: [UIViewController] = [] {
        didSet {
            updateCustomTabBarItems()
        }
    }
    
    // MARK: - init(nibName:bundle:)
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setupDummyTabBarController()
        setupCustomTabBar()
    }
    
    // MARK: - init(rootViewController:)
    public convenience init(rootViewController: UIViewController) {
        self.init(nibName: nil, bundle: nil)
        setRootViewController(rootViewController)
    }
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupDummyTabBarController() {
        dummyTabBarController = UITabBarController()
        dummyTabBarController.view.isHidden = true
        
        addChild(dummyTabBarController)
        view.addSubview(dummyTabBarController.view)
        dummyTabBarController.didMove(toParent: self)
    }
    
    private func setupCustomTabBar() {
        customTabBar = UICustomTabBar()
        customTabBar.delegate = self
    }
    
    private func setRootViewController(_ viewController: UIViewController?, removing previousViewController: UIViewController? = nil) {
        if let previousViewController {
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
    }
    
    private func layoutDummyTabBarControllerView() {
        dummyTabBarController.view.frame = view.frame
    }
    
    private func layoutRootViewControllerView() {
        rootViewController?.view.frame = view.frame
    }
    
    private func layoutCustomTabBar() {
        customTabBar.frame = dummyTabBarController.tabBar.frame
        guard customTabBar.superview == nil else { return }
        view.window?.addSubview(customTabBar)
        view.window?.bringSubviewToFront(customTabBar)
    }
    
    private func updateChildrenAdditionalSafeAreaInsets() {
        let inset = view.safeAreaInsets.bottom
        let height = dummyTabBarController.tabBar.frame.height - inset
        rootViewController?.additionalSafeAreaInsets.bottom = height
        rootViewController?.viewSafeAreaInsetsDidChange()
    }
    
    private func updateCustomTabBarItems() {
        customTabBar.items = viewControllers.map(\.tabBarItem)
        customTabBar.selectedItem = customTabBar.items?.first
    }
    
    // MARK: - viewWillLayoutSubviews()
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutDummyTabBarControllerView()
        layoutRootViewControllerView()
        layoutCustomTabBar()
        updateChildrenAdditionalSafeAreaInsets()
    }
    
    // MARK: - viewDidAppear(_:)
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let items: [UITabBarItem] = viewControllers.map(\.tabBarItem)
        guard let item = items.first else { return }
        tabBar(customTabBar, didSelect: item)
    }
    
    // MARK: - UITabBarDelegate
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        let viewController = viewControllers[index]
        
        if let sheetViewController = presentedViewController as? UITabBarSheetViewController {
            sheetViewController.setViewController(viewController)
        } else {
            let sheetViewController = UITabBarSheetViewController()
            sheetViewController.isModalInPresentation = true
            sheetViewController.setViewController(viewController)
            sheetViewController.sheetPresentationController?.prefersGrabberVisible = true
            sheetViewController.sheetPresentationController?.largestUndimmedDetentIdentifier = .medium
            sheetViewController.sheetPresentationController?.detents = [.constant(107), .medium(), .large(allowsScaling: false)]
            sheetViewController.additionalSafeAreaInsets.bottom = dummyTabBarController.tabBar.frame.height - view.safeAreaInsets.bottom
            
            present(sheetViewController, animated: false)
        }
    }
}
