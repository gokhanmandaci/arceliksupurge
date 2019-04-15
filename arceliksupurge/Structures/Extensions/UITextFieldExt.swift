//
//  UITextFieldExt.swift
//  SMCollector
//
//  Created by Gökhan Mandacı on 5.04.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

extension UITextField {
    
    /**
     Edits textfield letter spacing & line height.
     
     - Parameter kern: Takes kern to set label letter spacing
     - Parameter lineHeight: Takes lineHeight to set label line height
     
     ### Usage Example: ###
     ````
     textfield.setLetterSpacing(-0.3, 1.2)
     ````
     
     - Returns: None.
     */
    func setLetterSpacing(_ kern: CGFloat, _ lineHeight: CGFloat = 1.0) {
        guard let fnt = self.font, let txt = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: txt)
        attrString.addAttribute(NSAttributedString.Key.font, value: fnt, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
}
