//
//  WeatherDetailsView.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import SwiftUI

struct WeatherDetailsView: View {
    @EnvironmentObject var viewModel: WeatherDetailsViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(self.viewModel.weatherDetailsForCities ?? [], id: \.city.id) { weatherForecast in
                    WeatherDetailsRow(weatherForecast: weatherForecast)
                }
            }
            
            if viewModel.isLoading {
                ProgressView().tint(.blue)
            }
        }
        .navigationTitle("Weather Details")
        .task {
            await self.viewModel.callWeatherForecatAPI()
        }
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView()
    }
}
