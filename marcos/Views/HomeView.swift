//
//  HomeView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.fundinho.ignoresSafeArea()
            VStack{
                TodayDateView()
                InThisDayView()
            }
            
        }

    }
}

#Preview {
    HomeView()
}
