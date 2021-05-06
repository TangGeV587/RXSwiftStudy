//
//  NotificationController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift

class NotificationController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).subscribe(onNext:{
                    nofification in
                    print("UIApplication 进入后台",nofification)
                }).disposed(by: bag)
    }

}
