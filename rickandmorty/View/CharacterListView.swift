//
//  CharacterListView.swift
//  rickandmorty
//
//  Created by Mete Varol on 18.04.2023.
//

import SwiftUI
import Combine

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    var selectedLocation: Location?

    var body: some View {
        
        GeometryReader { geometry in
                    ZStack {
                        
                        Color("darkgray1")
                           
            
            
            ScrollView {
                LazyVStack(alignment: .center, spacing: 20) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(
                            destination: CharacterDetailView(viewModel: CharacterDetailViewModel(), character: character),
                            label: {
                                CharacterRowView(label: character.name, photo: character.image, gender: character.gender)
                                    .frame(maxWidth: .infinity)
                            }
                        )
                    }
                    
                }
                .padding(.vertical, 10)
            }
            
            if viewModel.characters.isEmpty {
                VStack {
                    Image("empty")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("There is no one here..\nMaybe a black hole swallowed them..")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("green1"))
                        .multilineTextAlignment(.center)
                }
            }
            
        }
    }
    }
}



struct CharacterListView_Previews: PreviewProvider {
    @State static private var selectedLocation:Location?
    
    static var previews: some View {
       CharacterListView(viewModel: CharacterListViewModel(),selectedLocation: selectedLocation)
        
    }
}
