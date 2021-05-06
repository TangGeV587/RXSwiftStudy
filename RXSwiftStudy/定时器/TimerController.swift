//
//  TimerController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift

class TimerController: UIViewController {
    
   let bag = DisposeBag()
   @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建信号
        let ob = Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.instance)

        ob.map{"计时:\($0)"}.bind(to: label.rx.text).disposed(by: bag)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
