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
    var score: BehaviorRelay<Int>
}

class MapController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let stu1 = Student(score: BehaviorRelay(value: 80))
        let stu2 = Student(score: BehaviorRelay(value: 100))
        let subject = PublishSubject<Student>()
        
        subject.asObserver().flatMapLatest{ (student) -> Observable<Int> in
            student.score.asObservable()
        }.subscribe(onNext: {print($0)} ).disposed(by: bag)
        
        subject.onNext(stu1)
        stu1.score.accept(77)

        subject.onNext(stu2)
        stu2.score.accept(66)
        stu1.score.accept(99)
        
    }
    
    //MARK: - Map 将Observable每个元素转换成Observables并将元素合并发送 忽略旧的事件(stu1不在监听)
    func testFlatMapLatest() {
        
        let stu1 = Student(score: BehaviorRelay(value: 80))
        let stu2 = Student(score: BehaviorRelay(value: 100))
        let subject = PublishSubject<Student>()
        
        subject.asObserver().flatMapLatest{ (student) -> Observable<Int> in
            student.score.asObservable()
        }.subscribe(onNext: {print($0)} ).disposed(by: bag)
        
        subject.onNext(stu1)
        stu1.score.accept(77)

        subject.onNext(stu2)
        stu2.score.accept(66)
        stu1.score.accept(99)
        
    }
    
    //MARK: - Map 将Observable每个元素转换成Observables并将元素合并发送 全部事件
    func testFlatMap() {
       
        let stu1 = Student(score: BehaviorRelay(value: 80))
        let stu2 = Student(score: BehaviorRelay(value: 100))
        let subject = PublishSubject<Student>()
        
        subject.asObserver().flatMap { (student) -> Observable<Int> in
            student.score.asObservable()
        }.subscribe(onNext: {print($0)} ).disposed(by: bag)
        
        subject.onNext(stu1)
        stu1.score.accept(77)

        subject.onNext(stu2)
        stu1.score.accept(99)

    }
    
    
    
    //MARK: - Map 将Observable每个元素通过条件过滤一遍
    func testFilter(){
        Observable.of(10,8,15,20).filter{ $0 > 10}.subscribe(onNext:{ print($0) }).disposed(by: bag)
    }
    
    
    //MARK: - Map 将Observable每个元素通过转换方法转换一遍
    func testMap(){
        //映射基本数据类型
        Observable.of(1,2,3).map{ $0 * $0 }.subscribe { event  in
            print(event)
        }.disposed(by: bag)
    }
}
