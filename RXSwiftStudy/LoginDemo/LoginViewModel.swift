//
//  LoginViewModel.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/5.
//

import UIKit
import RxSwift
import RxRelay

class LoginViewModel {

    var userNameSign = BehaviorRelay<String>(value: "")
    var pwdSign = BehaviorRelay<String>(value: "")
    var loadingSign = BehaviorRelay<Bool>(value: false)
    
    private var loginSubject = PublishSubject<User>()
    var loginModelOb:Observable<User> {  loginSubject  }
    
    //私有的可监听序列
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    var isTableHiddenOb:Observable<Bool> { isTableHidden.asObservable() }
    
    
    //手机号码是否有效,根据实际情况写业务规则
    var userValid:Observable<Bool> {
        return userNameSign.asObservable().map { userName in
            userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    //密码是否有效,根据实际情况写业务规则
    var pwdValid:Observable<Bool> {
        return pwdSign.asObservable().map{ $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    //判断是否加载指示器
    var loginBtnValid:Observable<Bool> {
        return Observable.combineLatest(userValid, pwdValid){ !$0 && !$1 }.share(replay:1)
    }
    
    
    func getData(){
        loadingSign.accept(true)
        
        let dictParam = ["userName":userNameSign.value,"pwd":pwdSign.value]
        DispatchQueue.global().async {
            self.loadingSign.accept(false)
            print(dictParam["userName"]!,dictParam["pwd"]!)
            //如果code 两百执行下面代码
            let user = User(token: "ssss", loginName: "tange", phone: "15068848741")
            self.loginSubject.onNext(user)
        }
        
    }
    
    
}
