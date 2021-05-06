//
//  KVOController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift
class KVOController: UIViewController {

    @objc dynamic var name:String? //要加上  @objc dynamic
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.rx.observe(String.self, "name").subscribe(onNext: { name in
            print("name is ", name ?? "--" )
        }).disposed(by: bag)
        
        self.name = "rose"
    }
    

}
