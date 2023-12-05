//
//  Detent+LargeAllowsScaling.swift
//
//
//  Created by Seb Vidal on 04/12/2023.
//

import UIKit

extension UISheetPresentationController.Detent {
    static func large(allowsScaling: Bool) -> UISheetPresentationController.Detent {
        if allowsScaling {
            return .large()
        } else {
            return .custom { context in
                context.maximumDetentValue * 0.999777
            }
        }
    }
}
