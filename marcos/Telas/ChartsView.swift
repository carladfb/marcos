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
        print(dateFormatter.string(from: Foundation.Date()))
    }
    
    var body: some View {
        
        NavigationStack {
            
            if !holidaysDAO.isLoading {
                VStack {
                    
                    if let holiday = holidaysDAO.recentsHolidays[0] {
                        HStack {
                            
                            DaysToView(date:
                                        String(holiday.holiday.date.datetime.month) + " / " + String(holiday.holiday.date.datetime.day)
                            )
                            
                            HolidayView(holiday: holiday)
                            
                        }
                        .padding(8)
                        .background(
                            Capsule().fill(Color.white)
                        )
                    } else {
                        Text("nao restam mais feriados")
                    }
                    
                    
                    
                    ForEach(1..<4) { i in
                        
                        if let holiday = holidaysDAO.recentsHolidays[i] {
                            HStack {
                                DaysToView(date:
                                            String(holiday.holiday.date.datetime.month) + " / " + String(holiday.holiday.date.datetime.day)
                                )
                                HolidayButtonView(holiday: holiday)
                            }
                            .padding(8)
                            .background(
                                Capsule().fill(Color.white)
                            )
                        }
                        
                        
                        
                        
                    }
                    
                    List {
                        ForEach(holidaysDAO.holidayWithStyle, id: \.self) {
                            holiday in
                            HolidayView(holiday: holiday)
                        }
                    }
                    ChartHolidaysPerMonthView(holidays: holidaysDAO.holidaysPerMonth, month: dateFormatter.string(from: Foundation.Date()))
                    
                }.padding()
                    .background(Color.fundinho)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Calendar")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ButtonCountries(holidaysDAO: holidaysDAO)
                            }
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                        }
                    }
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



