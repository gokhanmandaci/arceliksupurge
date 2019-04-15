//
//  UIViewExt.swift
//  solvemate
//
//  Created by Gökhan Mandacı on 15.03.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Adds oval cornerRadius to a view.
     
     - Returns: None.
     */
    func setOvalCornerRadius() {
        let cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
