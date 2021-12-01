//
//  SettingViewController.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/16.
//

import Foundation
import UIKit

class SettingViewController: MJBaseViewController {
    
    var titleField: UITextField!
    var inputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.swiftViewBgColor
        self.title = "设置"
        
        setupViews()

    }
    
    func setupViews() {
        
        let titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 20)
        titleLbl.textColor = UIColor.swiftMidBlackColor
        titleLbl.text = "输入主题"
        titleLbl.textAlignment = .center
        view.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(25)
        }
        
        titleField = UITextField()
        titleField.placeholder = "请输入主题";
        titleField.font = UIFont.systemFont(ofSize: 20)
        titleField.delegate = self
        titleField.clearButtonMode = .always
        titleField.returnKeyType = .done
        titleField.borderStyle = .roundedRect
        titleField.textColor = UIColor.swiftMidBlackColor
        self.view.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        let showLbl = UILabel()
        showLbl.font = UIFont.boldSystemFont(ofSize: 20)
        showLbl.textColor = UIColor.swiftMidBlackColor
        showLbl.text = "输入抽奖内容（每行一项）"
        showLbl.textAlignment = .center
        view.addSubview(showLbl)
        showLbl.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(25)
        }
        
        inputTextView = UITextView()
        inputTextView.backgroundColor = .white
        inputTextView.delegate = self
        inputTextView.font = UIFont.systemFont(ofSize: 20)
        inputTextView.textColor = UIColor.swiftMidBlackColor
        inputTextView.layer.borderColor = UIColor.lightGray.cgColor
        inputTextView.layer.borderWidth = 0.5
        inputTextView.layer.cornerRadius = 5
        inputTextView.layer.masksToBounds = true
        self.view.addSubview(inputTextView)
        inputTextView.snp.makeConstraints { make in
            make.top.equalTo(showLbl.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH - 40, height: 360))
        }
        
        let privacyBtn = UIButton(type: .custom)
        privacyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        privacyBtn.backgroundColor = UIColor.SMainThemeColor
        privacyBtn.setBackgroundImage(UIImage(named: "nav_bg"), for: .normal)
        privacyBtn.addTarget(self, action: #selector(finishBtnAction), for: .touchUpInside)
        privacyBtn.setTitle("完成", for: .normal)
        self.view.addSubview(privacyBtn)
        let hh:CGFloat = isiPhoneXScreen() ? 80 : 60
        privacyBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - nav_bar_h - hh, width: SCREEN_WIDTH, height: hh)
        
        let defaults = UserDefaults.standard
        if let value1 = (defaults.array(forKey: "foodkey") as? [String]) {
            let string = value1.joined(separator: "\n")
            inputTextView.text = string
        }
        
        if let value2 = defaults.string(forKey: "titleKey") {
            titleField.text = value2
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @objc func finishBtnAction() {
        
        if inputTextView.text == "" || inputTextView.text?.count == 0 {
            self.view.makeToast("请输入抽奖内容", duration: 3.0, position: .center)
            return
        }
        print(inputTextView.text ?? "")
        var arr: Array = inputTextView.text.components(separatedBy: "\n")
        for (index,value) in arr.enumerated().reversed() {
            if value == "" || value == " " {
                arr.remove(at: index)
            }
        }
        print(arr)
        
        let defaults = UserDefaults.standard
        defaults.setValue(arr, forKey: "foodkey")
        defaults.setValue(titleField.text ?? "", forKey: "titleKey")
        defaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
    }

}

extension SettingViewController: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//        }
//        return true
//    }
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
