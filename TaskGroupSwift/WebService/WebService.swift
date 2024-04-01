//
//  WebService.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import Foundation

final class WebService {
    private var urlSession: URLSession
    private var cityID: String
    
    init(
        urlSession: URLSession = .shared,
        cityID: String = ""
    ) {
        self.cityID = cityID
        self.urlSession = urlSession
    }
    
    private var serviceURL: String {
        return "https://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&units=metric&appid=\(Constants.apiKey)"
    }
    
    func getWeatherForecastData() async throws -> WeatherForecast {
        guard let url = URL(string: self.serviceURL) else {
            throw ErrorType.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw ErrorType.invalidResponse
        }
        
        do {
            let result = try JSONDecoder().decode(WeatherForecast.self, from: data)
            return result
        } catch {
            throw ErrorType.responseParsingError
        }
    }
}
