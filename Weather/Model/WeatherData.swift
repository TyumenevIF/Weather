//
//  WeatherData.swift
//  Weather
//
//  Created by Ilyas Tyumenev on 27.02.2024.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
}
