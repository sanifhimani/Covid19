//
//  RoundedView.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit

@IBDesignable public class RoundedUIView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
