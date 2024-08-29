//
//  ContentView.swift
//  marcos
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var holidaysDAO = HolidaysDAO()
    
    init() {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    
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
        }
        .accentColor(.vermeiTchan)
    }
}


#Preview {
    ContentView()
}
