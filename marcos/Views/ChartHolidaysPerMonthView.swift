//
//  ChartHolidaysPerMonthView.swift
//  marcos
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 28/08/24.
//

import SwiftUI
import Charts

struct ChartHolidaysPerMonthView: View {
    
    let holidays: [HolidayChart];
    let month: String;
    
    var body: some View {
        Chart {
            ForEach (holidays) {
                dado in
                BarMark(x: .value("", dado.monthName),
                        y: .value("", dado.numeroDeFeriados))
                .foregroundStyle(
                    month.prefix(3) == dado.monthName ?
                    Color.vermei :
                        Color.rosinhaGrafico)
                .annotation(position: .top, alignment: .center, spacing: CGFloat(5), content: {
                    Text(String(Int(dado.numeroDeFeriados))).font(.caption2)
                        .foregroundColor(month.prefix(3) == dado.monthName ?
                                         Color.vermei :
                                           Color.black)
                })
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
            }
            
            
        }
        .chartLegend(position: .bottom, alignment: .top, spacing: 16)
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 7)
        .padding(.vertical)
        .frame(height: 250)
    }
}

//#Preview {
  //  ChartHolidaysPerMonthView()
//}
