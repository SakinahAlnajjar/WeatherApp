//
//  ContentView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 15/08/2023.
//
import CoreLocation
import SwiftUI

struct WeatherScreen: View {
    @StateObject private var forecastListVM2 = WeatherManager()
    @StateObject private var forecastListVM = ListViewModel()
    //@State private var searchTxt : String = ""
    @State private var selection : Int = 0
    @State var weather : ResponseBody
    
    //var weather: ResponseBody
    var body: some View {
        NavigationStack {
            ZStack{
                Color.init(uiColor: UIColor(named: "bgColor") ?? .cyan).ignoresSafeArea()
                VStack {
                    Picker(selection: $selection, label: Text("System")) {
                        Text("°C").tag(0)
                        Text("°F").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 100)
                    .padding(.vertical)
                    
                    Group{
                        HStack {
                            TextField("search location", text: $forecastListVM2.city)
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
                            
                            Button {
                                forecastListVM2.getCurrentWeatherByCity()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    if forecastListVM2.isLoading == false {
                                        weather = forecastListVM2.weatherInfo!
                                    }
                                }
                            } label: {
                                Text("Search")
                            }
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
                        Text("\(forecastListVM2.convert(weather.main.temp, systemInt: selection).roundDouble())")
                            .font(.system(size: 70,
                                          weight: .bold, design: .rounded))
                            .padding(.top, 40)
                        HStack(alignment: .center, spacing: 18){
                            AsyncImage(url: weather.weather[0].weathericon)
                                .frame(width: 150, height: 150)
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
                }
                .ignoresSafeArea(SafeAreaRegions.all, edges: .bottom)
                .padding(.top, 40)
            }
            .alert(item: $forecastListVM.appError) { appAlert in
                Alert(title: Text("Error"),
                      message: Text("""
                        \(appAlert.errorString)
                        Please try again later!
                        """
                                   )
                )
            }.navigationBarBackButtonHidden(false)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen(weather: previewWeather)
    }
}
