//
//  LoadingView.swift
//  WeatherApp
//
//  Created by سكينه النجار on 17/08/2023.
//

import SwiftUI

struct LoadingView: View {
        var body: some View {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
