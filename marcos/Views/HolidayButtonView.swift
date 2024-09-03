import SwiftUI

struct HolidayButtonView: View {
    let holiday: HolidayWithStyle
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            showingSheet.toggle()
        }, label: {
            HStack {
                Text(holiday.holidayStyle.emoji)
                    .font(.callout)
                    .padding(6)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .opacity(0.35)
                    )
                Text(holiday.holiday.name)
                    .foregroundColor(.white)
                    .font(.callout)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                    .opacity(0.4)
                
            }
            .padding(.vertical, 5)
            .padding(.leading, 5)
            .padding(.trailing, 12)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(holiday.holidayStyle.cor)
            )
        })
        .sheet(isPresented: $showingSheet) {
            
            HolidayDetailView(holiday: holiday)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(40)
            
        }
    }
}
