//
//  CustomCellViewController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/18.
//

import UIKit
import RxSwift
import RxDataSources

class CustomCellViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sections:[MuiltySectionModel] = []
        
        
    }


}

enum MuiltySectionModel {
    case ImageProvidableSection(title:String,items:[SectionItem])
}

enum SectionItem {
    case ImageSectionItem(image:UIImage,title:String)
}
