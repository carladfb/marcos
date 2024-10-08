import SwiftUI

struct DashedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
            .foregroundColor(.vermeiTchan)
        }
    }
}

#Preview {
    DashedLine()
}
