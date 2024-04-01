//
//  CityListViewModel.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import Foundation

final class CityListViewModel: ObservableObject {
    @Published var shouldShowAlert: Bool = false
    @Published var isShowWeatherReportButtonTapped: Bool = false
    @Published var selectedCities: Set<CityModel> = []
    
    var cities: [CityModel] {
        return [
            CityModel(id: 1259229, name: "Pune"),
            CityModel(id: 1275339, name: "Mumbai"),
            CityModel(id: 1273294, name: "Delhi"),
            CityModel(id: 1277333, name: "Bengaluru"),
            CityModel(id: 1275841, name: "Bhopal"),
            CityModel(id: 1262321, name: "Mysore"),
            CityModel(id: 1269743, name: "Indore"),
            CityModel(id: 1275004, name: "Kolkata"),
            CityModel(id: 7279746, name: "Noida"),
            CityModel(id: 1269515, name: "Jaipur")
        ].sorted{$0.name < $1.name}
    }
}
