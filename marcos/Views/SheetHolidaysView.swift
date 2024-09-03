import SwiftUI

struct SheetHolidaysView: View {
    @StateObject private var holidaysDAO = HolidaysDAO()
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack {
            if let actualHoliday = holidaysDAO.actualHoliday {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Today's Holiday")
                            .font(.title3)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.bouncy(duration: 0.5)) {
                                rotation += 360
                                holidaysDAO.fetchDays(currentCountry: holidaysDAO.actualCountry?.iso3166 ?? "BR") 
                            }
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .rotationEffect(.degrees(rotation))
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    DashedLine()
                        .frame(height: 1)
                        .padding(.vertical, 5)
                    
                    ScrollView {
                        Text(actualHoliday.holiday.name)
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text(actualHoliday.holiday.description)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxHeight: 150)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
            } else {
                Text("No holiday today")
                    .padding()
            }
        }
        .onAppear {
            holidaysDAO.fetchDays(currentCountry: holidaysDAO.actualCountry?.iso3166 ?? "BR")
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
    }
}

#Preview {
    SheetHolidaysView()
}
