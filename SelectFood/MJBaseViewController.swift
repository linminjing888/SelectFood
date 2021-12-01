//
//  MJBaseViewController.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/16.
//

import UIKit

class MJBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func setupLayout() {}
    
    func configNavigationBar() {
        guard let navi = navigationController as? MJNaviViewController else { return }
        if navi.visibleViewController == self {
            
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_arrow")?.withRenderingMode(.alwaysOriginal),
                                                                   style: .plain,
                                                                   target: self,
                                                                   action: #selector(pressBack))
                navigationItem.leftBarButtonItem?.tintColor = .white
            }
        }
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
