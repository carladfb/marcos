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
            VStack {

                List {
                    
                    ForEach(holidaysDAO.holidayWithStyle, id: \.self) {
                        holiday in
                        
                        HolidayView(holidayName: holiday.holiday.name, holidaySytle: holiday.holidayStyle)
                        
                    }
                    
                }
                
                
                
                
                
                
                ChartHolidaysPerMonthView(holidays: holidaysDAO.holidaysPerMonth, month: dateFormatter.string(from: Foundation.Date()))
                
            }.padding()
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
        }
        
        
        
        
    }
    
    struct HolidayView: View {
        
        let holidayName: String;
        let holidaySytle: HolidayStyle;
        
        var body: some View {
            
            
            HStack {
                
                Text(holidaySytle.emoji)
                    .font(.footnote)
                    .padding(4)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .opacity(0.35)
                    )
                
                Text(holidayName)
                    .foregroundColor(.white)
                    .font(.body)
                    .lineLimit(0)
                
                Spacer()
                
                
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(holidaySytle.cor)
            )
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
    }
}





#Preview {
    ChartsView(holidaysDAO: HolidaysDAO())
}
