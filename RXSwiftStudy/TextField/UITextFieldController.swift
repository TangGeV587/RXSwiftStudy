//
//  UITextFieldController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/4.
//

import UIKit
import RxSwift

class UITextFieldController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.rx.text.subscribe { text in
            print(text!)
        }.disposed(by: bag)
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
