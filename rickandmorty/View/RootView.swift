//
//  RootView.swift
//  rickandmorty
//
//  Created by Mete Varol on 19.04.2023.
//

import SwiftUI

struct RootView: View {
    @State private var showSplashView = true
    
    var body: some View {
        VStack {
            if showSplashView {
                SplashView()
            } else {
                MainView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    showSplashView = false
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
