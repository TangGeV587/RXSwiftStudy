//
//  LoginViewModel.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/5.
//

import UIKit
import RxSwift

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewModel {

    //输出
    let userNameValid: Observable<Bool>
    let pwdValid: Observable<Bool>
    let combineValid: Observable<Bool>
    
    //输入 -> 输出
    
    init(userName: Observable<String>,pwd: Observable<String>) {
        
        //判断用户名输入框长度是否大于 5
        userNameValid = userName.map{ $0.count >= minimalUsernameLength}.share(replay: 1)
        //判断密码输入框是否大于 5
        pwdValid = pwd.map{$0.count >= minimalPasswordLength}.share(replay: 1)
        //组合判断所有条件是否成立
        combineValid = Observable.combineLatest(userNameValid, pwdValid){ $0 && $1}.share(replay: 1)
    }
    
}
