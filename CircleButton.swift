//
//  CircleButton.swift
//  Scribe
//
//  Created by Darshan Gowda on 26/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet{
            setUpView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
    
}
