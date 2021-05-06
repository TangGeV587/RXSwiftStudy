//
//  LoginViewController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/5.
//

import UIKit
import RxSwift
class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let bag = DisposeBag()
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userNameTF.rx.text.orEmpty.bind(to: viewModel.userNameSign).disposed(by: bag)
        pwdTF.rx.text.orEmpty.bind(to: viewModel.pwdSign).disposed(by: bag)
        
        //点击按钮
        
        loginBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.asyncInstance).subscribe(onNext: {
            [weak self] _ in
            self?.viewModel.getData()
        }).disposed(by: bag)
        
        //弹框
        viewModel.loadingSign.subscribe(onNext: { isLoading in
            if isLoading {
                print("弹出")
            }else {
                print("消失")
            }
        }).disposed(by: bag)
        
        //判断按钮是否可点击
        viewModel.loginBtnValid.bind(to: loginBtn.rx.isEnabled).disposed(by: bag)
        
        //订阅结果
        viewModel.loginModelOb.subscribe(onNext: {
            user in
            print(user.phone,user.loginName)
        }).disposed(by: bag)
        
    }

}
