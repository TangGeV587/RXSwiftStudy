//
//  CombineController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/7.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
class CombineController: UIViewController {
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
       
        
    }
    
    //MARK: - Observables元素组合起来，然后将组合结果发出来，成对的出现
    func testZip(){
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        Observable.zip(first, second){ $0 + $1}.subscribe(onNext: { print($0)}).disposed(by: bag)
        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
    }
    
    //MARK: - Observables元素组合起来,组合结果 排列(m * n)
    func testCombine(){
        
         let first = PublishSubject<String>()
         let second = PublishSubject<String>()
         
         Observable.combineLatest(first, second){ $0 + $1 }.share(replay: 1).subscribe(onNext: {print($0)}).disposed(by: bag)
         first.onNext("A")
         second.onNext("1")
         first.onNext("B")
         second.onNext("2")
    }
}
