//
//  CustomView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 15/08/2023.
//

import SwiftUI

struct CustomView: View {
    
    var weather: ResponseBody?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 70){
                VStack(alignment: .leading, spacing: 20){
                    rowView(icon: "humidity", title: "Humidity", value: "\(weather?.main.humidity ??  0.0)") //(weather.main.humidity.roundDouble() + "%"))
                    rowView(icon: "thermometer.high",title: "max temp", value: "\(weather?.main.tempMax ?? 0.0)")
                }
                VStack(alignment: .leading, spacing: 20) {
                    rowView(icon: "wind",title: "Wind speed", value: "\(weather?.wind.speed ?? 0.0)")//  + "m/s"
                    rowView(icon: "sparkles" ,title: "Feels like", value: "\(weather?.main.feelsLike ?? 0.0)")
                }
            }
        }
    }
    
    func rowView(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 15){
            Image(systemName: icon)
                .resizable()
                .frame(width: 25, height: 25)
            VStack(alignment: .leading) {
                Text(title)
                Text(value)
            }
        }
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}
