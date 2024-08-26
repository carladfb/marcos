//
//  ContentView.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
            }
            ChartsView().tabItem {
                VStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Charts")
                }
            }
            CountriesView().tabItem {
                VStack {
                    Image(systemName: "globe.americas.fill")
                    Text("Countries")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
