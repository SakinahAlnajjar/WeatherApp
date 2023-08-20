//
//  InitialView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 19/08/2023.
//

import SwiftUI
import CoreLocationUI

struct initialView: View {
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather data")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()

            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        initialView()
    }
}
