//
//  TableController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/5.
//

import UIKit
import RxSwift

class TableController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let bag = DisposeBag()
    var items:[Hero] = [Hero]()
    let datasource = Observable.just([
        Hero(name: "分组", introduce: "圣剑啊，你有看到那个敌人吗"),
        Hero(name: "后羿", introduce: "圣剑啊，你有看到那个敌人吗"),
        Hero(name: "白起", introduce: "圣剑啊，你有看到那个敌人吗"),
        ])
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"UITableViewCellID")
        datasource.bind(to: tableView.rx.items(cellIdentifier: "UITableViewCellID", cellType: UITableViewCell.self)){
            row ,hero,cell in
            cell.selectionStyle = .none
            cell.textLabel?.text = hero.name
            cell.detailTextLabel?.text = hero.introduce
        }.disposed(by: bag)

        tableView.rx.itemSelected.subscribe(onNext: {
            [weak self] indexpath in
           
            self?.jumpWithIndex(indexpath.row)
            
        }).disposed(by: bag)
    }
    
    
    func jumpWithIndex(_ index:Int){
        switch index {
        case 0:
            navigationController?.pushViewController(SectionTableViewController.init(), animated: true)
        default:
            print("其他")
        }
        
    }
    
}
