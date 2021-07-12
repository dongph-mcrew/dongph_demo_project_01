//
//  DetailViewController.swift
//  dongph_demo_project_01
//
//  Created by Dong Pham on 12/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: BehaviorRelay = BehaviorRelay<String>(value: "")
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.imageView.image = UIImage(systemName: imageName)
        self.imageName.map({ name in
            UIImage(systemName: name)
        }).bind(to: imageView.rx.image).disposed(by: bag)
        // Do any additional setup after loading the view.
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
