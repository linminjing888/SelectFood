//
//  LuckyResultViewController.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/17.
//

import UIKit
import SnapKit

class LuckyResultViewController: UIViewController, PopupProtocol {
    
    var resultStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
    }
    
    func setupViews() {
        
//        let btn = UIButton()
//        btn.titleLabel?.text = "返回"
//        btn.titleLabel?.textColor = .white
////        btn.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//        btn.backgroundColor = .red
//        btn.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(btn)
//
//        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        btn.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.7, height: SCREEN_WIDTH * 0.7))
        }
        
        let pointImg = UIImageView()
        pointImg.image = UIImage(named: "lottery_machine_result")
        pointImg.contentMode = .scaleAspectFill
        view.addSubview(pointImg)
        pointImg.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.85, height: SCREEN_WIDTH * 0.85))
        }
        
        let flowerImg = UIImageView()
        flowerImg.image = UIImage(named: "lottery_machine_ribbon")
        flowerImg.contentMode = .scaleAspectFill
        view.addSubview(flowerImg)
        flowerImg.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.95, height: SCREEN_WIDTH * 0.95))
        }
        
        let showLbl = UILabel()
        showLbl.font = UIFont.boldSystemFont(ofSize: 42)
        showLbl.textColor = UIColor.SMainThemeColor
        showLbl.text = ""
        showLbl.textAlignment = .center
        bgView.addSubview(showLbl)
        showLbl.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.7, height: 50))
        }
        
        if let str = resultStr {
            showLbl.text = str
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        PopupController.dismiss(self)
    }
    
    @objc func click() {
        PopupController.dismiss(self)
    }
}
