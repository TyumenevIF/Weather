//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ilyas Tyumenev on 27.02.2024.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    private let weatherView = WeatherView()
    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    // MARK: - let/var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.delegate = self
        weatherView.searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        setSubviews()
        setUpConstraints()
    }
    
    // MARK: - lifecycle funcs
    
    private func setSubviews() {
        view.addSubview(weatherView)
    }
    
    private func setUpConstraints() {
        weatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherView.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if weatherView.searchTextField.text != "" {
            return true
        } else {
            weatherView.searchTextField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = weatherView.searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        weatherView.searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.firstTempLabel.text = weather.temperatureString
            self.weatherView.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.weatherView.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


// MARK: - WeatherViewDelegate

extension WeatherViewController: WeatherViewDelegate {
    
    func weatherView(_ view: WeatherView, locationPressed sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func weatherView(_ view: WeatherView, searchPressed sender: UIButton) {
        weatherView.searchTextField.endEditing(true)
    }
}
