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
                    Text(String(Int(dado.numeroDeFeriados)))
                        .font(.caption)
                        .foregroundColor(month.prefix(3) == dado.monthName ?
                                         Color.vermei :
                                           Color.primary)
                })
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                
            }
            
            
        }
        .chartLegend(position: .bottom, alignment: .top, spacing: 16)
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 6)
        .padding(.vertical)
        .frame(height: 230)
    }
}

//#Preview {
  //  ChartHolidaysPerMonthView()
//}
