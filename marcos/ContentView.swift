//
//  ContentView.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var holidaysDAO = HolidaysDAO()
    
    var body: some View {
        TabView {
            HomeView(holidaysDAO: holidaysDAO).tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
            }
            ChartsView(holidaysDAO: holidaysDAO).tabItem {
                VStack {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Charts")
                }
            }
            CountriesView(holidaysDAO: holidaysDAO).tabItem {
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
