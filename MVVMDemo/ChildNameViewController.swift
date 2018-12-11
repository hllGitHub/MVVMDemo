//
//  ChildNameViewController.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ChildNameViewController: AddChildBaseViewController {
    var disposeBag = DisposeBag()
    
    let containerView: UIView = {
        let view = UIView.newAutoLayout()
        return view
    }()
    
    let nextButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.isEnabled = false
        button.backgroundColor = .blue
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    let nameField: UITextField = {
        let textField = UITextField.newAutoLayout()
        textField.tintColor = .blue
        textField.keyboardType = .alphabet
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "Input Name", attributes: [.foregroundColor: UIColor.gray])
        textField.contentVerticalAlignment = .center
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always;
        return textField
    }()
    
    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGes = UITapGestureRecognizer()
        tapGes.rx.event.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.dismissKeyboard()
        }).disposed(by: self.disposeBag)
        view.addGestureRecognizer(tapGes)
        
        titleLabel.text = "Add Name"
        
        //
        setupViews()
        bingData()
        
        view.setNeedsUpdateConstraints()
        view.readableContentGuide.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        view.readableContentGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(nameField)
        view.addSubview(nextButton)
    }
    
    func bingData() {
        // 创建Observable
        let text = nameField.rx.text.orEmpty.asObservable()
        // 绑定到viewModel
        let viewModel = ChildNameViewModel(username: text)
        
        // 订阅-反馈
        viewModel.canAddEnabled.subscribe(onNext: { [weak self] valid in
            guard let self = self else {
                return
            }
            self.nextButton.isEnabled = valid
            self.nextButton.alpha = valid ? 1.0 : 0.5
        }).disposed(by: self.disposeBag)
        
        // button-tap
        nextButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.AddChildName()
        }).disposed(by: self.disposeBag)
    }
    
    func AddChildName() {
        let alertController = UIAlertController.init(title: "Message", message: "Add child successfully", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            containerView.autoConstrainAttribute(.top, to: .bottom, of: titleLabel, withOffset: 80)
            containerView.autoSetDimension(.height, toSize: 50)
            
            nameField.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
            nextButton.autoSetDimension(.width, toSize: 240)
            nextButton.autoPin(toBottomLayoutGuideOf: self, withInset: 60)
            nextButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    @objc private func dismissKeyboard() {
        _ = nameField.resignFirstResponder()
    }
}

