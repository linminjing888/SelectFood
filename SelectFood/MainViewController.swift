//
//  ViewController.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/16.
//

import UIKit
import Toast_Swift
import CoreLocation
import Alamofire
import SwiftyJSON

class MainViewController: MJBaseViewController {

    var showLbl: UILabel!
    var resultLbl: UILabel!
    var locationManager = CLLocationManager()
    var allCount: NSInteger = 0;
    var timerEngine: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = "活动清单"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "visitor_setting_icon"), style: .plain, target: self, action: #selector(addAction))
        
        let luckyBtn = UIButton(type: .custom)
        luckyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        luckyBtn.setBackgroundImage(UIImage.creatColorImage(UIColor.SMainThemeColor!), for: .normal)
        luckyBtn.addTarget(self, action: #selector(luckyAction), for: .touchUpInside)
        luckyBtn.setTitle("开始", for: .normal)
        luckyBtn.layer.cornerRadius = 50
        luckyBtn.layer.masksToBounds = true
        self.view.addSubview(luckyBtn)
        luckyBtn.frame = CGRect(x: (SCREEN_WIDTH - 100)/2, y: SCREEN_HEIGHT - nav_bar_h - tab_bar_h - 100, width: 100, height: 100)
        
        showLbl = UILabel()
        showLbl.font = UIFont.systemFont(ofSize: 25)
        showLbl.textColor = UIColor.SMainThemeColor
        showLbl.text = ""
        showLbl.textAlignment = .center
        self.view.addSubview(showLbl)
        showLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        if let value2 = UserDefaults.standard.string(forKey: "weatherKey") {
            if value2 != "" {
                showLbl.text = value2
            }
        }
        
        resultLbl = UILabel()
        resultLbl.font = UIFont.systemFont(ofSize: 25)
        resultLbl.textColor = UIColor.SMainThemeColor
        resultLbl.text = ""
        resultLbl.textAlignment = .center
        self.view.addSubview(resultLbl)
        resultLbl.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        locationInit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let value2 = UserDefaults.standard.string(forKey: "titleKey") {
            if value2 != "" {
                self.title = value2
            }
        }
    }
    
    @objc func addAction() {
        
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func luckyAction() {

        let defaults = UserDefaults.standard
        guard (defaults.array(forKey: "foodkey") as? [String]) != nil else {
            
            self.view.makeToast("请先设置奖项", duration: 3.0, position: .center)
            return
        }

        timerEngine = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startAction), userInfo: nil, repeats: true)

    }
    
    @objc func startAction() {
        
        let defaults = UserDefaults.standard
        if let value1 = (defaults.array(forKey: "foodkey") as? [String]) {
            
            let randomNum = Int.random(in: 0..<value1.count)
            print(value1[randomNum])
            self.resultLbl.text = value1[randomNum]

            allCount += 1
            if allCount >= 25 {
                
                allCount = 0
                timerEngine?.invalidate()
                timerEngine = nil
                
                let resultVC = LuckyResultViewController()
                resultVC.resultStr = value1[randomNum]
                PopupController.show(resultVC)
                
            }
            
//            let customView = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//            PopupController.show(customView)
            
        }
    }

}


class CustomView: UIView, PopupProtocol {
    
    override init(frame: CGRect) {
          super.init(frame: frame)
        
          setupViews()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      func setupViews() {
          
          let btn = UIButton(frame: bounds)
          btn.titleLabel?.text = "返回"
          btn.titleLabel?.textColor = .white
          btn.addTarget(self, action: #selector(click), for: .touchUpInside)
          btn.backgroundColor = .red

          self.addSubview(btn)
    }
        
    @objc func click() {
        PopupController.dismiss(self)
    }
}

// 定位
extension MainViewController: CLLocationManagerDelegate {
    
    func locationInit() {
        // 定位
        locationManager.delegate = self
        // 精确度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 权限
        locationManager.requestWhenInUseAuthorization()
        // 请求一次位置
        locationManager.requestLocation()
        //        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocation = locations[0]
        if location.horizontalAccuracy > 0 {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print("纬度:\(long) 经度:\(lat)")
        }
        
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let cityName = placemarks?.last?.locality
            print("城市名字:\(cityName ?? "")")
            
            self.loadWeather(city: cityName ?? "suzhou")
        }
        //        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("获取位置失败 \(error)")
    }
}

extension MainViewController {
    
    func loadWeather(city:String) {
        let paras:[String : Any] = ["key":"osoydf7ademn8ybv",
                                    "location":city,
                                    "language":"zh-Hans",
                                    "start":0,
                                    "days":1]
        AF.request("https://api.thinkpage.cn/v3/weather/daily.json", method: .get, parameters: paras).responseJSON { (response) in
            
            switch(response.result) {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    
                    self.updateData(json: json)
                case .failure(let error):
                    print("Error message:\(error)")
            }
        }
    }
    
    func updateData(json:JSON) {
        
        let cityName = json["results"][0]["location"]["name"].stringValue
 
        let wea = json["results"][0]["daily"][0]["text_day"].stringValue
  
        let low = json["results"][0]["daily"][0]["low"]
        let height = json["results"][0]["daily"][0]["high"]
        
        showLbl.text = cityName + " " + wea + " " + "\(low)°C / \(height)°C"
        
        let defaults = UserDefaults.standard
        defaults.setValue(showLbl.text, forKey: "weatherKey")
        defaults.synchronize()
        
    }
}
