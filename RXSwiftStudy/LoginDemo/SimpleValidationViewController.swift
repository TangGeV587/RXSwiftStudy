//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController : UIViewController {
    var bag = DisposeBag()
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!

    @IBOutlet weak var doSomethingOutlet: UIButton!

    var viewModel:SimpleValidationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        viewModel = SimpleValidationViewModel(userName: usernameOutlet.rx.text.orEmpty.asObservable(), pwd: passwordOutlet.rx.text.orEmpty.asObservable())
        
        //用户名长度大于5 密码框才可以输入
        viewModel.userNameValid.bind(to: passwordOutlet.rx.isEnabled).disposed(by: bag)
        //用户名长度大于5,提示文本隐藏
        viewModel.userNameValid.bind(to: usernameValidOutlet.rx.isHidden).disposed(by: bag)
        // 密码长度大于5 ，提示文本隐藏
        viewModel.pwdValid.bind(to: passwordValidOutlet.rx.isHidden).disposed(by: bag)
        //用户名、密码长度都大于6 按钮可以点击
        viewModel.combineValid.bind(to: doSomethingOutlet.rx.isEnabled).disposed(by: bag)
        
        doSomethingOutlet.rx.tap.subscribe { _ in
            print("dddddd")
            self.showAlert()
        }.disposed(by: bag)
    }

    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
