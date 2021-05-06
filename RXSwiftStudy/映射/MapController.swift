//
//  MapController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift
import RxRelay

struct Student {
    var score: BehaviorRelay<Double>
}

class MapController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        var stu1 = Student(score: BehaviorRelay(value: 80))
//        let stu2 = Student(score: BehaviorRelay(value: 100))
        let stu3 = BehaviorRelay(value: stu1)
        stu3.flatMapLatest{$0.score}.subscribe(onNext: { score in
                        print(score)
                    }).disposed(by: bag)
        stu1.score = BehaviorRelay(value: 99)
        //映射Observable
//        stu3.flatMap { $0.score }.subscribe(onNext: { score in
//            print(score)
//        }).disposed(by: bag)
//        stu1.score = BehaviorRelay(value: 99)
//        stu3.value.score = 0
    }
    
    func test1(){
        //映射基本数据类型
        Observable.of(1,2,3).map{ $0 * $0 }.subscribe { event  in
            print(event)
        }.disposed(by: bag)
    }
}
