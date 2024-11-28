import SwiftUI

struct WelcomeView: View {
  @State private var isShown = false
  @State private var selectedTextIndex = 0
  let welcomeTexts: [String] = ["Welcome to Buddies", "domi & Nathan™", "Happy riding!"]

  var body: some View {

    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
        NavigationLink(destination: RegisterView()) {

      VStack {
          
        Spacer()
        ForEach(0..<welcomeTexts.count) { index in
          Text(welcomeTexts[index])
            .font(.system(size: selectedTextIndex == index ? 30 : 24, weight: .bold))
            .foregroundColor(selectedTextIndex == index ? .white : .gray)
            .scaleEffect(selectedTextIndex == index ? 1 : 0.7)
            .offset(y: CGFloat(index - selectedTextIndex) * 50)
            .opacity(selectedTextIndex == index ? 1 : 0)
            .rotation3DEffect(
              .degrees(Double(index - selectedTextIndex) * 60),
              axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.spring(), value: selectedTextIndex)
        }
        Spacer()
          Text("tap anywhere to get started")
            .font(.footnote)
            .bold()
            .foregroundColor(.gray)
            .padding()
        }
      }
      .padding(16)
    }
    .onAppear {
      isShown = true
      Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
        withAnimation {
          selectedTextIndex = (selectedTextIndex + 1) % welcomeTexts.count
        }
      }
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
