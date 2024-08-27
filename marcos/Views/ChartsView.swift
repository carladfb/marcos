//
//  ChartsView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 26/08/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @ObservedObject var holidaysDAO = HolidaysDAO()
    let dateFormatter: DateFormatter;
                   
    init() {
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "MMMM"
        print(dateFormatter.string(from: Foundation.Date()))
    }


    
    var body: some View {
        GeometryReader {
            geometry in
            VStack {
                
                List {
                    
                    ForEach(holidaysDAO.holidays, id: \.self) {
                        holiday in
                        Text(holiday.name)
                    }
                    
                }
                

                
                //  ScrollView(.horizontal) {
                HStack {
                    Chart {
                        ForEach (holidaysDAO.holidaysPerMonth) {
                            dado in
                            BarMark(x: .value("", dado.monthName),
                                    y: .value("", dado.numeroDeFeriados))
//                            .foregroundStyle(
//                                Color.cinzinha)
                            .foregroundStyle(
                                dateFormatter.string(from: Foundation.Date()).prefix(3) == dado.monthName ?
                                Color.vermei :
                                Color.rosinhaGrafico)
                            .annotation(position: .top, alignment: .center, spacing: CGFloat(5), content: {
                                Text(String(Int(dado.numeroDeFeriados))).font(.caption2)
                                    .foregroundColor(dateFormatter.string(from: Foundation.Date()).prefix(3) == dado.monthName ?
                                Color.vermei :
                                Color.black)
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            
                        }
                        
                        
                    }
                    .chartLegend(position: .bottom, alignment: .top, spacing: 16)
                    .chartScrollableAxes(.horizontal)
                    .chartXVisibleDomain(length: 6)
                    
                    .padding(.vertical)
                    .frame(height: 300)
                  
                    
                    
                    
                    
                }
            }.padding()
        }
        
    }
}





#Preview {
    ChartsView()
}
