//
//  AllHolidaysView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 02/09/24.
//

import SwiftUI

struct AllHolidaysView: View {
    
    @ObservedObject var holidaysDAO: HolidaysDAO;
    
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                VStack {
                    Text("Past holidays")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .padding(.horizontal, 6)
                        .bold()
                    VStack (alignment: .leading, spacing: 7){
                        ForEach(holidaysDAO.pastHolidays, id: \.self) {
                            holiday in
                            HStack {
                                DaysToView(date:
                                            holidaysDAO.holidaysPerMonth[holiday.holiday.date.datetime.month - 1].monthName + " / " + String(holiday.holiday.date.datetime.day),
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
                    
                    
                    Text("Future holidays")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .bold()
                    
                    VStack (alignment: .leading, spacing: 7){
                        ForEach(holidaysDAO.recentsHolidays, id: \.self) {
                            holiday in
                            HStack {
                                DaysToView(date:
                                            holidaysDAO.holidaysPerMonth[holiday!.holiday.date.datetime.month - 1].monthName + " / " + String(holiday!.holiday.date.datetime.day),
                                           space: 6
                                )
                                HolidayButtonView(holiday: holiday!)
                            }
                            .padding(9)
                            .background(
                                Capsule().fill(Color.white)
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
                
                
            }
            
        }
        .navigationTitle("All holidays")
        .background(Color.fundinho)
        
    }
    

}



