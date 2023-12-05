//
//  UIVisualEffectView+BackdropView.swift
//
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

extension UIVisualEffectView {
    var backdropView: UIView? {
        return subviews.first { subview in
            String(describing: type(of: subview)) == "_UIVisualEffectBackdropView"
        }
    }
}
