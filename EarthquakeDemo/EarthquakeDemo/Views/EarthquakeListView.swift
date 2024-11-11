//
//  Untitled.swift
//  EarthquakeDemo
//
//  Created by ychen327 on 2024/11/10.
//
import SwiftUI
import MapKit
struct EarthquakeListView: View {
    @StateObject private var viewModel = EarthquakeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.earthquakes, id: \.id) { earthquake in
                NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake)) {
                    EarthquakeRowView(earthquake: earthquake)
                }
            }
            .navigationTitle("Earthquakes")
            .task {
                await viewModel.fetchEarthquakes()
            }
        }
    }
    
    struct EarthquakeRowView: View {
        let earthquake: Feature
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(earthquake.properties.place ?? "Unknown Location")
                    .font(.headline)
                    .foregroundColor(isSevere ? .red : .primary)
                
                Text("Magnitude: \(earthquake.properties.mag ?? 0.0, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(isSevere ? .red : .primary)
                
                Text("Time: \(formatTime(earthquake.properties.time))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
        
        private var isSevere: Bool {
            (earthquake.properties.mag ?? 0.0) >= 7.5
        }
        
        private func formatTime(_ timestamp: Int?) -> String {
            guard let timestamp = timestamp else { return "N/A" }
            let date = Date(timeIntervalSince1970: Double(timestamp) / 1000)
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
    }

}

