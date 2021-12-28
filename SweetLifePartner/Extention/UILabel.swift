//
//  UILabel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 18/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setDiffColor(color: UIColor, range: NSRange) {
         let attText = NSMutableAttributedString(string: self.text!)
         attText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
         attributedText = attText
    }
}
