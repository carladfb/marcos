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
                    
                    
                    VStack (alignment: .leading, spacing: 7){
                        
                        
                        Text("Next Special Day")
                        
                        
                        if let holiday = holidaysDAO.recentsHolidays[0] {
                            HStack {
                                
                                DaysToViewRectangle(date:
                                                        holidaysDAO.holidaysPerMonth[holiday.holiday.date.datetime.month - 1].monthName
                                                         + " / " + String(holiday.holiday.date.datetime.day),
                                                    space: 16
                                )
                                
                                HolidayView(holiday: holiday, space: 4)
                                
                            }
                            .padding(9)
                            .background(
                                RoundedRectangle(cornerRadius: 20).fill(Color.fundinho2)
                            )
                        } else {
                            Text("No Special Day in this year")
                        }
                        
                        
                        Text("Upcoming Dates")
                        
                        
                        
                        
                        
                            .padding(.top, 16)
                        
                        ForEach(1..<4) { i in
                            
                            if let holiday = holidaysDAO.recentsHolidays[i] {
                                HStack {
                                    DaysToView(date:
                                                holidaysDAO.holidaysPerMonth[holiday.holiday.date.datetime.month - 1].monthName + " / " + String(holiday.holiday.date.datetime.day),
                                               space: 6
                                    )
                                    HolidayButtonView(holiday: holiday)
                                }
                                .padding(9)
                                .background(
                                    Capsule().fill(Color.fundinho2)
                                )
                            }
                            
                        }
                        
                        HStack {
                            Text("Past special days")
                            Spacer()
                            NavigationLink {
                                AllHolidaysView(holidaysDAO: holidaysDAO)
                            } label: {
                                Text("View all")
                                    .bold()
                            }

                        }
                        

                        
                        
                            .padding(.top, 16)
                        
                        CustomProgressView(progress: holidaysDAO.progressHolidays, lineHeight: 20, holidaysDAO: holidaysDAO,
                                           final: holidaysDAO.holidayWithStyle.count, numberProgress: holidaysDAO.holidayWithStyle.count - holidaysDAO.recentsHolidays.count)
                        .padding(.horizontal)
                        
                        
                        
                        Text("Special Day per Month")
                        
                            .padding(.top, 32)
                        
                        ChartHolidaysPerMonthView(holidays: holidaysDAO.holidaysPerMonth, month: dateFormatter.string(from: Foundation.Date()))
                        
                        
                        
                        
                        
                        Text("This Year ends in")
                        
                            .padding(.top, 16)
                        
                        CustomProgressView(progress: holidaysDAO.progressYear, lineHeight: 20, holidaysDAO: holidaysDAO,
                                           final: holidaysDAO.daysInThisYear, numberProgress: holidaysDAO.pastDays)
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                        
                        
                        
                        
                        
                        
                        
                        
                    }.padding(.horizontal, 30)
                    
                    
                }.background(Color.fundinho)
                
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Charts")
                                    .font(.title)
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
    
    struct CustomProgressView: View {
        var progress: Double
        var lineHeight: CGFloat = 20
        var holidaysDAO: HolidaysDAO;
        let final: Int;
        let numberProgress: Int;
        
        var body: some View {
            VStack {
                
                
                HStack {
                    
                    Text(String(numberProgress))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.vermeiTchan)
                    
                }
                
                HStack (spacing: 0) {
                    
                    Text(String(0)).font(.caption)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: lineHeight / 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: lineHeight)
                            
                            RoundedRectangle(cornerRadius: lineHeight / 2)
                                .fill(Color.vermeiTchan)
                                .frame(width: CGFloat(progress) * geometry.size.width, height: lineHeight)
                                .animation(.easeInOut, value: progress)
                        }
                    }
                    .frame(height: lineHeight)
                    .padding(.horizontal)
                    
                    Text(String(final))
                        .font(.caption)
                    
                }
                
                
            }
        }
    }
    
    
}




