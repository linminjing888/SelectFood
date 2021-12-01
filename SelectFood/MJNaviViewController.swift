//
//  MJNaviViewController.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/16.
//

import Foundation
import UIKit

class MJNaviViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground() // 重置背景和阴影颜

            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.backgroundColor = UIColor.clear
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
          
            navigationBar.barStyle = .black
            navBarAppearance.backgroundImage = UIImage(named: "nav_bg");
            navBarAppearance.shadowImage = UIImage();
            self.navigationBar.isTranslucent = false;
            
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationBar.standardAppearance = navBarAppearance
        }else{
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: .default)
            navigationBar.shadowImage = UIImage()
        }
    
        self.navigationBar.tintColor = UIColor.white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
