//
//  UIButtonExt.swift
//  solvemate
//
//  Created by Gökhan Mandacı on 17.03.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     Edits button letter spacing & line height.
     
     - Parameter kern: Takes kern to set label letter spacing
     - Parameter lineHeight: Takes lineHeight to set label line height
     
     ### Usage Example: ###
     ````
     button.setLetterSpacing(-0.3, 1.2)
     ````
     
     - Returns: None.
     */
    func setLetterSpacing(_ kern: CGFloat, _ lineHeight: CGFloat = 1.0){
        guard let titleLbl = self.titleLabel, let fnt = titleLbl.font, let txt = titleLbl.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = titleLbl.textAlignment
        
        let attrString = NSMutableAttributedString(string: txt)
        attrString.addAttribute(NSAttributedString.Key.font, value: fnt, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSMakeRange(0, attrString.length))
        titleLbl.attributedText = attrString
    }
    
}
