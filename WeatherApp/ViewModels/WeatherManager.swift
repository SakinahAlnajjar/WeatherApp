//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by سكينه النجار on 16/08/2023.
//

import Foundation
import CoreLocation
import SwiftUI
class WeatherManager : ObservableObject {
    public static let shared = WeatherManager()
    @AppStorage ("city name") var city: String = "Riyadh"
    @Published var error: String?
    @Published var weatherInfo: ResponseBody?
    @Published var isLoading = true
    @Published var unitSelection: Int = 0
    var system: Int = 0
    
    func fetchWeatherData() {
        guard !city.isEmpty else {
            error = "Please enter a city name"
            return
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(unitSelection == 0 ? "metric" : "imperial")&appid=c7db4fe03ea68fc185a5016056d858c6") else {
            error = "Invalid API URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.error = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(ResponseBody.self, from: data)
                DispatchQueue.main.async {
                    self.weatherInfo = weatherData
                    self.error = nil
                }
            } catch {
                self.error = "Error decoding weather data: \(error.localizedDescription)"
            }
        }.resume()
    }
    
    func getCurrentWeather(lat: CLLocationDegrees, long: CLLocationDegrees) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\("c7db4fe03ea68fc185a5016056d858c6")&units=matric") else {
            error = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.error = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherInfo = try decoder.decode(ResponseBody.self, from: data)
                DispatchQueue.main.async {
                    self.weatherInfo = weatherInfo
                    self.error = nil
                }
            } catch {
                self.error = "Error decoding weather data: \(error.localizedDescription)"
            }
        }.resume()
    }
    
    func getCurrentWeatherByCity() {
        self.isLoading = true
        guard !city.isEmpty else {
            city = "Riyadh"
            return
        }
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=c7db4fe03ea68fc185a5016056d858c6") else {
            error = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                self.error = error?.localizedDescription ?? "Unknown error"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherInfo = try decoder.decode(ResponseBody.self, from: data)
                DispatchQueue.main.async {
                    self.weatherInfo = weatherInfo
                    self.isLoading = false
                    self.error = nil
                }
            } catch {
                self.error = "Error decoding weather data: \(error.localizedDescription)"
            }
        }.resume()
    }

    func convert(_ temp: Double, systemInt : Int) -> Double {
        let celsius = temp - 273.5
        if systemInt == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
}
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
        var weathericon: URL {
            let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: urlString)!
        }
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}
