import SwiftUI

struct HolidayView: View {
    
    let holiday: HolidayWithStyle?
    let space: Int
    
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            if holiday != nil {
                showingSheet.toggle()
            }
        }, label: {
            HStack {
                Text(holiday?.holidayStyle.emoji ?? "😕")
                    .font(.title2)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .opacity(0.35)
                    )
                Text(holiday?.holiday.name ?? "Today is a normal day")
                    .foregroundColor(.white)
                    .font(.body)
                    .lineLimit(1)
                
                Spacer()
                
                if let _ = holiday {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                        .opacity(0.4)
                }
            }
            .padding(.vertical, CGFloat(space))
            .padding(.leading, 7)
            .padding(.trailing, 12)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(holiday?.holidayStyle.cor ?? Color.capsulaNãoEspecial)
            )
        })
        .sheet(isPresented: $showingSheet) {
            if let holiday = holiday {
                HolidayDetailView(holiday: holiday)
                    .presentationDetents([.fraction(0.5)]) 
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(40)
            }
        }
    }
}
