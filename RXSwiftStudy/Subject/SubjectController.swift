//
//  SubjectController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift
import RxCocoa
class SubjectController: UIViewController {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

       //Subject既是Observable 也是 Observer ,既可以发出事情也可以监听事件
//        BehaviorRelay.takeLast(<#T##self: BehaviorRelay<_>##BehaviorRelay<_>#>)
        let subject = BehaviorRelay(value:"3")
        subject.subscribe { event  in
            print(event)
        }.disposed(by: bag)
        subject.accept("helo")
    }
    
    //BehaviorRelay
    func test3(){
        //相当于BehaviorSubject的装箱,让订阅者订阅时 需要asObservable转成Observable
        let subject = BehaviorRelay(value:"3")
        subject.subscribe { event  in
            print(event)
        }.disposed(by: bag)
        subject.accept("helo")
    }

    //BehaviorSubject
    func test2(){
    //BehaviorSubject 能收到订阅之前的最后一个事件
        let subject =  BehaviorSubject(value: "a") //展示默认数据
        subject.subscribe { event  in
            print(event)
        }.disposed(by: bag)
        subject.onNext("helo")
    }
    
    
    //ReplaySubject
    func test1(){
        //ReplaySubject 能收到 订阅之前 & 订阅之后 发生的事件，onNext()、onError()、onCompleted()
        let subject =  ReplaySubject<String>.createUnbounded()
        subject.onNext("666")
        subject.onNext("555")
        subject.onNext("444")
        subject.subscribe { event  in
            print(event)
        }.disposed(by: bag)
        subject.onNext("helo")
    }
    
    //PublishSubject
    func test(){
        //PublishSubject 只能收到 订阅之前发生的事件，onNext()、onError()、onCompleted()
        let subject =  PublishSubject<String>()
          subject.onNext("666")
          subject.subscribe { event  in
              print(event)
          }.disposed(by: bag)
          subject.onNext("helo")
    }


}
