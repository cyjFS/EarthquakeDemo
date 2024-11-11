//
//  EarthquakeViewModel.swift
//  EarthquakeDemo
//
//  Created by ychen327 on 2024/11/10.
//

import Foundation
import Combine

@MainActor
class EarthquakeViewModel: ObservableObject {
    @Published var earthquakes: [Feature] = []
    
    func fetchEarthquakes() async {
        guard let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(EarthquakeResponse.self, from: data)
            earthquakes = response.features
        } catch {
            print("Failed to fetch or decode earthquake data: \(error)")
        }
    }
}
