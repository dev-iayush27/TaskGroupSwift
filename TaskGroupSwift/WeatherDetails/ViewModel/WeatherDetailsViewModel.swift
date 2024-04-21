//
//  WeatherDetailsViewModel.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import Foundation

@MainActor
final class WeatherDetailsViewModel: ObservableObject {
    @Published var weatherDetailsForCities: [WeatherForecast] = []
    @Published var error: ErrorType?
    @Published var isLoading: Bool = false
    
    var selectedCities: [CityModel]
    
    init(selectedCities: [CityModel]) {
        self.selectedCities = selectedCities
    }
    
    func callWeatherForecatAPI() async {
        self.isLoading = true
        self.weatherDetailsForCities.removeAll()
        var weatherDetails: [WeatherForecast] = []
        Task {
            try await withThrowingTaskGroup(of: WeatherForecast.self) { group in
                weatherDetails.reserveCapacity(selectedCities.count)
                for city in selectedCities {
                    group.addTask {
                        let webService = WebService(cityID: String(city.id))
                        return try await webService.getWeatherForecastData()
                    }
                }
                
                for try await weatherDetailsForCity in group {
                    weatherDetails.append(weatherDetailsForCity)
                }
            }
            
            self.isLoading = false
            self.weatherDetailsForCities = weatherDetails
        }
    }
}
