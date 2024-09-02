//
//  HomeView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fundinho.ignoresSafeArea()
                VStack {
                    TodayDateView()
                    HolidayView(holiday:
                                    holidaysDAO.actualHoliday,
                                space: 6
                                
                    )
                    .padding(.horizontal, 30)
                    InThisDayView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("What's Next?")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ButtonCountries(holidaysDAO: holidaysDAO)
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    HomeView(holidaysDAO: HolidaysDAO())
}
