//
//  ViewController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/4/13.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    let dataSource = Observable.just([
        "UILabel","UIButton","UITextField","Timer","KVO","Notification","Observable","Subject","Map","Table","LoginView","Combine"
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RxSwiftDemo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: UITableViewCell.self)){
            row , name,cell in
            cell.textLabel?.text = name
        }.disposed(by: bag)
        
        tableView.rx.contentOffset.subscribe { contentOffset in
            print(contentOffset)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { cellName in
            let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
            let vcNameStr = cellName + "Controller"
            let className = NSClassFromString("\(workName).\(vcNameStr)") as! UIViewController.Type
            self.navigationController?.pushViewController(className.init(), animated: true)
            
        }).disposed(by: bag)
//        tableView.rx.itemSelected.subscribe(onNext: { indexpath in
//
//        }).disposed(by: bag)
        
    }
    
    //任务依赖
    func test(){
//        API.token(username: "beeth0ven", password: "987654321")
//            .flatMapLatest(API.userInfo)
//            .subscribe(onNext: { userInfo in
//                print("获取用户信息成功: \(userInfo)")
//            }, onError: { error in
//                print("获取用户信息失败: \(error)")
//            })
//            .disposed(by: disposeBag)
        
    }
    
    //多任务等待结果
    func test1(){
//        Observable.zip(
//              API.teacher(teacherId: teacherId),
//              API.teacherComments(teacherId: teacherId)
//            ).subscribe(onNext: { (teacher, comments) in
//                print("获取老师信息成功: \(teacher)")
//                print("获取老师评论成功: \(comments.count) 条")
//            }, onError: { error in
//                print("获取老师信息或评论失败: \(error)")
//            })
//            .disposed(by: disposeBag)
    }
}

