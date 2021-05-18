//
//  SectionTableViewController.swift
//  RXSwiftStudy
//
//  Created by 玉堂赵 on 2021/5/10.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa



struct MySecion {
    var header: String
    var items:[Item]
    
}

extension MySecion: AnimatableSectionModelType {
    typealias Item = Int
    var identity: String {
        header
    }
    
    init(original: MySecion, items: [Int]) {
        self = original
        self.items = items
    }
}

class SectionTableViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let bag = DisposeBag()
    var dataSource: RxTableViewSectionedAnimatedDataSource<MySecion>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "分组cell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        let datasource = RxTableViewSectionedAnimatedDataSource<MySecion>( configureCell: { s, tableV, indexpath, item in
            let cell = tableV.dequeueReusableCell(withIdentifier: "sectionCell") ?? UITableViewCell(style: .default, reuseIdentifier: "sectionCell")
            cell.textLabel?.text = String(item)
            return cell
        }, titleForHeaderInSection: { ds, index in
            
            return ds.sectionModels[index].header
            
        })
        self.dataSource = datasource
        
        let sections = [MySecion(header: "first section", items: [1,2]),MySecion(header: "second section", items: [3,4])]
        Observable.just(sections).bind(to: tableView.rx.items(dataSource: datasource)).disposed(by: bag)
        tableView.rx.setDelegate(self).disposed(by: bag)
    }

}

extension SectionTableViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = dataSource?[indexPath], dataSource?[indexPath.section] != nil else {
            return 0.0
        }
        print(item)
        return 60.0
    }
}
