//
//  ObservableController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift

class ObservableController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //自定义监听对象
       let observe = AnyObserver<Int>.init { event in
            switch event {
            case .next(let data):
                print(data)
            case .completed:
            print("完成")
            case .error(let error):
                print(error)
            }
        }
        
        Observable.of(1,3).subscribe(observe).dispose()
        
    }
    
    
    
    
    func test5(){
        let ob = Observable.repeatElement("hello world")
        ob.take(5).subscribe { event in
            print(event)
        }.dispose()
    }
    
    //range
    func test4(){
        let ob = Observable.range(start: 1, count: 10)
        
        ob.subscribe { event in
            print(event)
        }.dispose()
    }
    
    //创建可监听序列
    func test3(){
        let ob = Observable<Int>.create { observer in
             observer.onNext(18)
             observer.onCompleted()
             return Disposables.create()
         }
     
         ob.subscribe { event in
                    print(event)
                }.dispose()
    }
    
    func test1(){
        //      let ob = Observable.just(1)
//               let ob = Observable.from([1,2,3])
                let ob = Observable.of(1,2,3)
                ob.subscribe { event in
                    print(event)
                }.dispose()

        //        ob.subscribe { value in
        //            print(value)
        //        } onError: { error in
        //            print("错误")
        //        } onCompleted: {
        //            print("完成")
        //        } onDisposed: {
        //            print("销毁")
        //        }.dispose()
    }
    
    func test2(){
        
        //        let ob = Observable<Any>.never()
        //        ob.subscribe { event in
        //            print(event)
        //        }.dispose()
                
        //        let ob = Observable<Any>.empty()
        //        ob.subscribe { event in
        //            print(event)
        //        }.dispose()
    }

}
