//
//  Detent+Fraction.swift
//
//
//  Created by Seb Vidal on 05/12/2023.
//

import UIKit

extension UISheetPresentationController.Detent {
    static func fraction(_ value: CGFloat) -> UISheetPresentationController.Detent {
        return .custom { context in
            context.maximumDetentValue * value
        }
    }
}
