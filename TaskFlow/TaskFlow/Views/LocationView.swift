//
//  LocationView.swift
//  TaskFlow
//
//  Created by İlknur Tulgar on 28.10.2025.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .frame(height: 250)
                .cornerRadius(16)
                .shadow(radius: 4)
            
            List {
                Section(header: Text("Durum")) {
                    Text(viewModel.locationStatusText)
                }
                
                Section(header: Text("Mevcut Konum")) {
                    if let location = viewModel.currentLocation {
                        Text("Latitude: \(location.latitude)")
                        Text("Longitude: \(location.longitude)")
                    } else {
                        Text("Konum alınıyor...")
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Konumum")
        .onAppear {
            viewModel.checkLocationPermission()
        }
    }
}


#Preview {
    LocationView()
}
