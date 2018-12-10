//
//  AddChildBaseViewController.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import PureLayout

class AddChildBaseViewController: UIViewController {

    let titleLabel = UILabel(font: UIFont.systemFont(ofSize: 16), color: .cyan)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.autoPin(toTopLayoutGuideOf: self, withInset: 62)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
