//
//  ChartsView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO;
    let dateFormatter: DateFormatter;
    
    init(holidaysDAO: HolidaysDAO) {
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "MMMM"
        self.holidaysDAO = holidaysDAO;
        
        
    }

    
    var body: some View {
        
        NavigationStack {
            if !holidaysDAO.isLoading {
                ScrollView {
                    
                    
                    VStack (spacing: 7){
                        
                        HStack {
                            Text("Next Special Day")
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        if let holiday = holidaysDAO.recentsHolidays[0] {
                            HStack {
                                
                                DaysToViewRectangle(date:
                                                        String(holiday.holiday.date.datetime.month) + " / " + String(holiday.holiday.date.datetime.day),
                                                    space: 8
                                )
                                
                                HolidayView(holiday: holiday, space: 4)
                                
                            }
                            .padding(9)
                            .background(
                                RoundedRectangle(cornerRadius: 20).fill(Color.white)
                            )
                        } else {
                            Text("No Special Day in this year")
                        }
                        
                        HStack {
                            Text("This Month")
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        ForEach(1..<4) { i in
                            
                            if let holiday = holidaysDAO.recentsHolidays[i] {
                                HStack {
                                    DaysToView(date:
                                                String(holiday.holiday.date.datetime.month) + " / " + String(holiday.holiday.date.datetime.day),
                                               space: 6
                                    )
                                    HolidayButtonView(holiday: holiday)
                                }
                                .padding(9)
                                .background(
                                    Capsule().fill(Color.white)
                                )
                            }
                            
                        }
                        
                        HStack {
                            Text("Special Day per Month")
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        ChartHolidaysPerMonthView(holidays: holidaysDAO.holidaysPerMonth, month: dateFormatter.string(from: Foundation.Date()))
                    }
                    
                }.padding(.horizontal, 30)
                    .background(Color.fundinho)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Charts")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ButtonCountries(holidaysDAO: holidaysDAO)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .toolbarBackground(.bar, for: .navigationBar)
                    .toolbarBackground(Color.fundinho, for: .navigationBar)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .accentColor(Color.vermeiTchan)
                
            }
            
            
            
        }
        
    }
}

#Preview {
    ChartsView(holidaysDAO: HolidaysDAO())
}



