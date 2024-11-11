//
//  EarthquakeMapView.swift
//  EarthquakeDemo
//
//  Created by ychen327 on 2024/11/11.
//

import SwiftUI
import MapKit

struct EarthquakeDetailView: View {
    let earthquake: Feature
    @State private var region: MKCoordinateRegion

    init(earthquake: Feature) {
        self.earthquake = earthquake
        _region = State(initialValue: MKCoordinateRegion(
            center: earthquake.geometry.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        ))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Map(coordinateRegion: $region, annotationItems: [earthquake]) { location in
                // 使用 Marker 替换 MapPin
                MapMarker(coordinate: location.geometry.coordinate, tint: .red)
            }
            .frame(height: 300)
            .cornerRadius(10)
            .padding(.bottom, 8)

            Text("Location:")
                .font(.headline)
            Text(earthquake.properties.place ?? "Unknown Location")
                .font(.title)
                .padding(.bottom, 8)

            Text("Magnitude:")
                .font(.headline)
            Text("\(earthquake.properties.mag ?? 0.0, specifier: "%.1f")")
                .font(.title)
                .foregroundColor(.red)
                .padding(.bottom, 8)

            Text("Time:")
                .font(.headline)
            Text(formatTime(earthquake.properties.time))
                .font(.body)
                .padding(.bottom, 8)

            Spacer()
        }
        .padding()
        .navigationTitle("Earthquake Details")
        .navigationBarTitleDisplayMode(.inline)
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
