//
//  Extision.swift
//  WeatherApp
//
//  Created by سكينه النجار on 18/08/2023.
//

import Foundation
import SwiftUI
extension Double {
    func roundDouble () -> String {
        return String(format: "%.0f", self)
    }
}
extension View {
    func CornerRadius(_ raduis: CGFloat, corners: UIRectCorner) ->  some View
    {
        clipShape(RoundedCorner(radius: raduis , corner: corners))
    }
}
    
    struct RoundedCorner : Shape {
        
        var radius : CGFloat = .infinity
        var corner :UIRectCorner = .allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }


