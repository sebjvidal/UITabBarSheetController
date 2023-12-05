//
//  UIVisualEffectView+GroupName.swift
//  
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

extension UIVisualEffectView {
    var groupName: String? {
        get {
            return value(forKey: "_groupName") as? String
        } set {
            perform(Selector(("_setGroupName:")), with: newValue)
        }
    }
}
