//
//  InitialView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 19/08/2023.
//

import SwiftUI
import CoreLocationUI

struct initialView: View {
    // @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = WeatherManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            if let weather = viewModel.weatherInfo {
                if locationManager.isLoading == false {
                    WeatherScreen(weather: weather)
                }
            } else {
                VStack(spacing: 20) {
                        Text("Get current weather")
                            .padding()
                            .bold()
                            .font(.title)
                        LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                            if let location = locationManager.location {
                                viewModel.getCurrentWeather(lat: location.latitude, long: location.longitude)
                            }
                        }
                        .cornerRadius(30)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                }
            }.navigationBarBackButtonHidden(true)
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        initialView()
    }
}
