//
//  ViewController.swift
//  dongph_demo_project_01
//
//  Created by Dong Pham on 12/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var bag = DisposeBag()
    let viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bindDataTableView()
    }
    
    func bindDataTableView() {
        let _: () = self.searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({ query in
                self.viewModel.items.value.filter({ item in
                    query.isEmpty || item.name.lowercased().contains(query.lowercased())
                    
                })
            })
            .bind(to: self.tableView.rx.items(cellIdentifier: "cell")) { index, model, cell in
            cell.textLabel?.text = model.name
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        //binding handler
        self.tableView.rx.modelSelected(Product.self).bind { item in
            
            let detailVC = (self.storyboard?.instantiateViewController(identifier: "DetailVC"))! as DetailViewController
            //detailVC.imageName = item.imageName
            detailVC.imageName.accept(item.imageName)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }.disposed(by: bag)
        
        self.tableView.rx.modelDeleted(Product.self).bind { item in
            print(item.name)
        }.disposed(by: bag)
    }
}

struct ProductViewModel {
    
//    var items = Observable.just([
//        Product(imageName: "house", name: "Home"),
//        Product(imageName: "gear", name: "Settings"),
//        Product(imageName: "person.circle", name: "Profile"),
//        Product(imageName: "airplane", name: "Flights"),
//        Product(imageName: "bell", name: "Activity"),
//    ])
    
    var items = BehaviorRelay.init(value: [
        Product(imageName: "house", name: "Home"),
        Product(imageName: "gear", name: "Settings"),
        Product(imageName: "person.circle", name: "Profile"),
        Product(imageName: "airplane", name: "Flights"),
        Product(imageName: "bell", name: "Activity"),
    ])
    
    func fetchData() {
        
    }
    
}

struct Product {
    var imageName: String
    var name: String
}
