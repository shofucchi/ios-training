//
//  WeatherModel.swift
//  iOSTraining
//
//  Created by Shota Fuchikami on 2021/05/27.
//

import YumemiWeather

/// APIラッパークラス
class WeatherModel {
    
    /// ランダムで天候の文字列を返却する
    /// - Returns: sunny, cloudy or rainy
    static func fetchWeather() -> String {
        let weather = YumemiWeather.fetchWeather()
        Logging.log(message: weather)
        return weather
    }
    
    /// ランダムで天候の文字列を返却する
    /// エラーの場合 nil を返却する
    /// - Parameter at: where
    /// - Returns: sunny, cloudy rainy or nil
    static func fetchWeather(at: String) -> String? {
        do {
            let weather = try YumemiWeather.fetchWeather(at: at)
            Logging.log(message: "Fetch Success: weather \(weather) at \(at)")
            return weather
        } catch {
            Logging.log(message: "Error: \(error)")
            return nil
        }
    }
    
    /// ランダムで天候のJson文字列を返却する
    /// - Parameter jsonString: リクエストパラメータ
    /// - Returns: Json文字列
    static func fetchWeather(_ jsonString: String) -> String? {
        let json = try? YumemiWeather.fetchWeather(jsonString)
        return json
    }
    
}
