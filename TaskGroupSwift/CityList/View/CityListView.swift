//
//  CityListView.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var viewModel: CityListViewModel = CityListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select multiple cities")
                    .bold()
                    .padding(.horizontal, 17)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                List {
                    ForEach(viewModel.cities, id: \.id) { city in
                        CityListRow(
                            title: city.name,
                            isSelected: self.viewModel.selectedCities.contains(city)
                        ) {
                            if self.viewModel.selectedCities.contains(city) {
                                self.viewModel.selectedCities.remove(city)
                            } else {
                                self.viewModel.selectedCities.insert(city)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
                
                Button(action: {
                    if !self.viewModel.selectedCities.isEmpty {
                        self.viewModel.isShowWeatherReportButtonTapped = true
                    } else {
                        self.viewModel.shouldShowAlert = true
                    }
                }) {
                    HStack {
                        Text("Show Weather Report")
                            .font(.headline)
                    }
                }
                .foregroundColor(.blue)
            }
            .navigationDestination(
                isPresented: self.$viewModel.isShowWeatherReportButtonTapped,
                destination: {
                    let viewModel = WeatherDetailsViewModel(
                        selectedCities: Array(self.viewModel.selectedCities)
                    )
                    WeatherDetailsView().environmentObject(viewModel)
                }
            )
            .alert(isPresented: $viewModel.shouldShowAlert) {
                Alert(
                    title: Text("Alert!"),
                    message: Text("Please select cities."),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .navigationTitle("Weather App")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
