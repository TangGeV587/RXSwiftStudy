//
//  UILabelController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift

class UILabelController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let binder = Binder(label) { (label, text) in
            label.text = text
        }
        
        Observable.just(2).map { "文本是:\($0)" }.bind(to: binder).disposed(by: bag)
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
