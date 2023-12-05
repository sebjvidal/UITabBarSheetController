//
//  UICustomTabBar.swift
//  
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

class UICustomTabBar: UITabBar {
    // MARK: - Internal Properties
    var backgroundView: UIView? {
        return subviews.first { subview in
            String(describing: type(of: subview)) == "_UIBarBackground"
        }
    }
    
    var visualEffectView: UIVisualEffectView? {
        return backgroundView?.subviews.first as? UIVisualEffectView
    }
    
    // MARK: - Private Methods
    private func updateVisualEffectView() {
        visualEffectView?.effect = UIBlurEffect(style: .systemMaterial)
        visualEffectView?.perform(Selector(("_setGroupName:")), with: "Backdrop Group")
    }
    
    // MARK: - layoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        updateVisualEffectView()
    }
}
