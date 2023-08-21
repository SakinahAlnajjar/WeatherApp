//
//  Intro.swift
//  WeatherApp
//
//  Created by سكينه النجار on 19/08/2023.
//

import SwiftUI

struct Intro: View {
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherScreen(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    initialView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
}



struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
