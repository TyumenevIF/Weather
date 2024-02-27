//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ilyas Tyumenev on 27.02.2024.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    private let weatherView = WeatherView()
    
    // MARK: - let/var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.delegate = self
        weatherView.searchTextField.delegate = self
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
}

// MARK: - WeatherViewDelegate

extension WeatherViewController: WeatherViewDelegate {
    
    func weatherView(_ view: WeatherView, locationPressed sender: UIButton) {
    }
    
    func weatherView(_ view: WeatherView, searchPressed sender: UIButton) {
    }
}
