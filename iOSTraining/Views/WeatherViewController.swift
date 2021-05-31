//
//  WeatherViewController.swift
//  iOSTraining
//
//  Created by Shota Fuchikami on 2021/05/26.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logging.log(message: "start viewDidLoad")
        initView()
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil, using: { _ in
            self.loadWeather()
        })
    }
    
    @IBAction private func onClickReloadButton(_ sender: Any) {
        loadWeather()
    }
    
    @IBAction private func onClickCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initView() {
        weatherImageView.backgroundColor = .clear
        minTempLabel.text = Const.Label.invalid_text
        minTempLabel.font = UIFont.systemFont(ofSize: CGFloat(Const.Label.temp_font_size))
        maxTempLabel.text = Const.Label.invalid_text
        maxTempLabel.font = UIFont.systemFont(ofSize: CGFloat(Const.Label.temp_font_size))
    }
    
    private func loadWeather() {
        let parameter = Parameter(area: Const.Place.tokyo, date: DateUtil.formatDate(format: Const.Date.yyyyMmDdTHhMmSsZZZZZ))
        guard let request = JsonUtil.jsonEncode(param: parameter) else { return }
        
        let result = WeatherModel.fetchWeather(request)
        
        DispatchQueue.main.async {
            switch result.responseStatus {
            case .success:
                guard let weatherData = result.data else { return }
                self.weatherImageView.set(weather: weatherData.weather)
                self.minTempLabel.set(temp: weatherData.minTemp)
                self.maxTempLabel.set(temp: weatherData.maxTemp)
            case .failure, .notRequest:
                let content = AlertContent(title: Const.Alert.title, message: Const.Alert.message, action: UIAlertAction(title: Const.Alert.button_title, style: .default, handler: nil))
                AlertUtil.present(vc: self, content: content)
            }
        }
    }
    
}
