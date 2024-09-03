import SwiftUI

struct TodayDateView: View {
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: Foundation.Date())
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Foundation.Date()).uppercased()
    }
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 120).bold())
            Text(month)
                .font(.system(size: 20))
        }
        .padding(.bottom, 80)
    }
}

struct TodayDateView_Previews: PreviewProvider {
    static var previews: some View {
        TodayDateView()
    }
}
