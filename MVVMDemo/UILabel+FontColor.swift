//
//  UILabel+FontColor.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit

public extension UILabel {
    public func configure(font: UIFont, color: UIColor) {
        textColor = color
        self.font = font
    }
    
    convenience init(font: UIFont, color: UIColor) {
        self.init()
        textColor = color
        self.font = font
    }
}
