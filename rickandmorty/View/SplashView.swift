

import SwiftUI
import Combine

struct SplashView: View {
    @StateObject private var appState = AppState()
    @State private var animationFinished = false
    @State private var rotationDegree: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("darkgray1")
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 200)
                        
                    
                    if !animationFinished {
                
                        Image("rick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding(.bottom, 20)
                            .rotationEffect(Angle(degrees: rotationDegree))
                            .animation(.easeInOut(duration: 1.0).repeatCount(3), value: rotationDegree)
                        
                    }
                    
                    Text(appState.welcomeText)
                        .font(.largeTitle)
                        .animation(.easeInOut(duration: 1.0))
                        .fontWeight(.heavy)
                        .opacity(animationFinished ? 1 : 0)
                        .foregroundColor(Color("green1"))
                }
                .onAppear {
                    appState.fetchWelcomeText()
                    rotationDegree = 1080 // 360 derece * 3
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            animationFinished = true
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


class AppState: ObservableObject {
    @Published var welcomeText: String = ""
    
    private var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isFirstLaunch")
        }
    }
    
    func fetchWelcomeText() {
        if isFirstLaunch {
            welcomeText = "Hello!"
        } else {
            welcomeText = "Welcome!"
            isFirstLaunch = true
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
