//
//  WeatherView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 18/08/2023.
//

import SwiftUI

struct WeatherView: View {
    var weather : ResponseBody = load("WeatherData.json")
    var body: some View {
        ZStack (alignment: .leading) {
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today , \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    
                }.frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                                VStack{
                                    HStack{
                                        VStack(spacing: 10){
                                            Image(systemName: "sun.max")
                                                .font(.system(size: 40))
                                            Text(weather.weather[0].main)
                                        }
                                        .frame(width: 150, alignment: .leading)
                                        Spacer()
                
                                        Text(weather.main.feelsLike.roundDouble() + "0")
                                            .font(.system(size: 100))
                                            .fontWeight(.bold)
                                            .padding()
                                    }
            }
                    
                        .frame(height: 80)
                }
                .frame(maxWidth: .infinity)
            }
            padding()
                .frame(maxWidth: .infinity , alignment: .leading)
            
        VStack{
            Spacer()
            VStack(alignment: .leading, spacing: 20){
            }
            .frame(maxWidth: .infinity , alignment: .leading)
            .padding()
            .padding(.bottom , 20)
            .foregroundColor(Color(hue: 0.656, saturation: 0.842, brightness: 0.483))
            .background(.white)
            .CornerRadius(20, corners: [.topLeft, .topRight])
        
            } .edgesIgnoringSafeArea(.bottom)
            .background(Color(hue: 0.655, saturation: 0.842, brightness: 0.483))
            .preferredColorScheme(.dark)
        }
       
    }


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
