//
//  ContentView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 15/08/2023.
//

import SwiftUI

struct WeatherScreen: View {
    
    @State var searchTxt : String = ""
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        ZStack{
            Color.init(uiColor: UIColor(named: "bgColor") ?? .cyan).ignoresSafeArea()
            VStack {
                
                
                if let location = locationManager.location{
                    if let weather = weather {
                       WeatherView(weather: weather)
                    }
                    else {
                        LoadingView()
                            .task {
                                do{
                                  weather =  try await
                                    weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
                                }
                                catch{
                                    print("error weather: \(error) ")
                                }
                            }
                    }
                }
                Group{
                    TextField("search", text: $searchTxt)
                        .padding()
                        .font(.title2)
                        .frame(height: 50)
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth:1)
                            Image(systemName: "magnifyingglass")
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity , alignment: .trailing)
                        }
                    
                    VStack(alignment: .leading){
                        Text("City")
                        Text("Date 19")
                    }
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                    
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                VStack(spacing: 5){
                    Text("8")
                        .font(.system(size: 120,
                                      weight: .bold, design: .rounded))
                    HStack(alignment: .center, spacing: 25){
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.yellow)
                        Text("Clear")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                    }
                }
                .foregroundColor(.white)
                
                Spacer()
                
                ZStack{
                    Rectangle()
                        .cornerRadius(30)
                        .foregroundColor(.white)
                        .frame(height: 270)
                    VStack(alignment: .leading, spacing: 30){
                        Text("weather now:")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        CustomView()
                    }.padding()
                }
            }.ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen()
    }
}
