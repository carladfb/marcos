import SwiftUI

struct DaysToViewRectangle: View {
    let date: String;
    let space: Int;
    
    
    var body: some View {
        Text(date)
            .font(.headline)
            .padding(.vertical, CGFloat(space))
            .padding(.horizontal, 5)
            .frame(maxWidth: 120)
            .background(
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color.fundinho)
            )
    }
}


