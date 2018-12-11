//
//  LoginViewController.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

/**
 *  登录模块
 */

import UIKit
import RxCocoa
import RxSwift

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class LoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let containerView: UIView = {
        let view = UIView.newAutoLayout()
        return view
    }()
    
    // 登录
    let loginButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.isEnabled = false
        button.backgroundColor = .blue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    // 用户名
    let usernameField: UITextField = {
        let textField = UITextField.newAutoLayout()
        textField.tintColor = .blue
        textField.keyboardType = .alphabet
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "Input Username", attributes: [.foregroundColor: UIColor.gray])
        textField.contentVerticalAlignment = .center
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.leftViewMode = .always;
        return textField
    }()
    
    // 密码
    let passwordField: UITextField = {
        let textField = UITextField.newAutoLayout()
        textField.tintColor = .blue
        textField.keyboardType = .alphabet
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "Input Password", attributes: [.foregroundColor: UIColor.gray])
        textField.contentVerticalAlignment = .center
        textField.borderStyle = .none
        textField.returnKeyType = .done
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.leftViewMode = .always;
        return textField
    }()
    
    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()
        bindingData()
        
        view.setNeedsUpdateConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(usernameField)
        containerView.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
    func bindingData() {
        let usernameObservable = usernameField.rx.text.orEmpty.asObservable()
        let passwordObservable = passwordField.rx.text.orEmpty.asObservable()
        
        let viewModel = LoginViewModel(
            input: (username: usernameObservable, password: passwordObservable)
        )
        
        // 订阅信号
        viewModel.logInEnabled.subscribe(onNext: { [weak self] valid in
            guard let self = self else {
                return
            }
            self.loginButton.isEnabled = valid
            self.loginButton.alpha = valid ? 1.0 : 0.5
        }).disposed(by: self.disposeBag)
        
        loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            sleep(2)
            self.showAlert()
        }).disposed(by: self.disposeBag)
    }
    
    func showAlert() {
        let alertController = UIAlertController.init(title: "提示", message: "登录成功", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "好的", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            containerView.autoPinEdge(toSuperviewEdge: .left, withInset: 30)
            containerView.autoPinEdge(toSuperviewEdge: .right, withInset: 30)
            containerView.autoAlignAxis(toSuperviewAxis: .vertical)
            containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 260)
            containerView.autoSetDimension(.height, toSize: 140)
            
            usernameField.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            usernameField.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            usernameField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            usernameField.autoSetDimension(.height, toSize: 40)
            
            passwordField.autoPinEdge(.top, to: .bottom, of: usernameField, withOffset: 10)
            passwordField.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
            passwordField.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            passwordField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
            passwordField.autoSetDimension(.height, toSize: 40)
            
            loginButton.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
            loginButton.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
            loginButton.autoPin(toBottomLayoutGuideOf: self, withInset: 60)
            loginButton.autoSetDimension(.height, toSize: 50)
            loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}
