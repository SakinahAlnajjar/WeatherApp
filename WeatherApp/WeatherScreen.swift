//
//  ContentView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 15/08/2023.
//
import CoreLocation
import SwiftUI

struct WeatherScreen: View {
    @StateObject private var forecastListVM = WeatherManager()
    @State  private var searchTxt : String = ""
    var weather: ResponseBody
    
    var body: some View {
        ZStack{
            Color.init(uiColor: UIColor(named: "bgColor") ?? .cyan).ignoresSafeArea()
            VStack {
                Picker(selection: $forecastListVM.system, label: Text("System")) {
                    Text("°C").tag(0)
                    Text("°F").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.vertical)
                Group{
                    TextField("search location", text: $searchTxt)
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
                        Text("\(weather.name)")
                    }
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                    
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                VStack(spacing: 5){
                    Text("\(weather.main.temp)")
                        .font(.system(size: 50,
                                      weight: .bold, design: .rounded))
                        .padding(.top, 100)
                    HStack(alignment: .center, spacing: 25){
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.yellow)
                        Text("\(weather.weather[0].main)")
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
                        CustomView(weather: weather)
                    }.padding()
                }
            }.ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
            
            
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen(weather: previewWeather)
    }
}
