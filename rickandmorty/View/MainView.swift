//
//  ContentView.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//


import SwiftUI

struct MainView: View {
    @StateObject private var locationListViewModel = LocationListViewModel()
    @StateObject private var characterListViewModel = CharacterListViewModel() 

    @State private var selectedLocation: Location?
    
    
    var body: some View {
        NavigationView{  
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200,height: 60)
                .clipped()
            Spacer()
            Spacer()
            LocationListView(viewModel: locationListViewModel, viewModel2: characterListViewModel, selectedLocation: $selectedLocation)
                     CharacterListView(viewModel: characterListViewModel, selectedLocation: selectedLocation)
                .background(Color("darkgray1"))
            
        }
        .background(Color("darkgray1"))
    }
        .tint(Color.white)
    }
    
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

