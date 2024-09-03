import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @StateObject var holidaysDAO = HolidaysDAO()
    
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(holidaysDAO)
        } else {
            ZStack {
                Color.red
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("logo")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    Text("What's Next?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.top, 20)
                }
            }
            .onAppear {
                holidaysDAO.fetchDays(currentCountry: "BR")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    
    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
