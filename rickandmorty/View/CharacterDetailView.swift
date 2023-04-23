//
//  CharacterDetailView.swift
//  rickandmorty
//
//  Created by Mete Varol on 18.04.2023.
//

import SwiftUI

struct AvenirText: View {
    let text: String
    let size: CGFloat
    let weight: Font.Weight
    
    var body: some View {
        Text(text)
            .font(.custom("Avenir", size: size))
            .fontWeight(weight)
    }
}

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var character: Character
    
    func episodeNumber(from url: String) -> Int? {
        if let episodeNumber = url.split(separator: "/").last {
            return Int(episodeNumber)
        }
        return nil
    }
    
    var body: some View {
        VStack {
            Color("darkblue1")
                .edgesIgnoringSafeArea(.all)
                .frame(height: 0)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 15) {
                  
                    
                    HStack{
                        Spacer()
                        AvenirText(text: character.name, size: 30, weight: .bold)
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                   
                   
                    AsyncImage(url: URL(string: character.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 275, height: 275)
                    .padding(.horizontal, 65)
                    .padding(.top, 10)
                    
                    
                   
                    HStack{
                        AvenirText(text: "Status:", size: 22, weight: .bold)
                            .frame(width: 100, alignment: .leading)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                        AvenirText(text: character.status, size: 22, weight: .regular)
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    }
                    
                   
                    HStack{
                        AvenirText(text: "Specy:", size: 22, weight: .bold)
                            .padding(.horizontal, 20)
                            .frame(width: 140, alignment: .leading)
                            .foregroundColor(Color.white)
                        AvenirText(text: character.species, size: 22, weight: .regular)
                            .foregroundColor(Color.white)
                    }
                    
                    HStack{
                        AvenirText(text: "Gender:", size: 22, weight: .bold)
                            .frame(width: 100, alignment: .leading)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 20)
                        
                        AvenirText(text: character.gender, size: 22, weight: .regular)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    HStack{
                        AvenirText(text: "Origin:", size: 22, weight: .bold)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                        AvenirText(text: character.origin.name, size: 22, weight: .regular)
                            .padding(.horizontal, 30)
                            .foregroundColor(Color.white)
                    }
                    
                    HStack{
                        AvenirText(text: "Location:", size: 22, weight: .bold)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                        AvenirText(text: character.location.name, size: 22, weight: .regular)
                            .padding(.horizontal, 8)
                            .foregroundColor(Color.white)
                    }
                    HStack {
                        AvenirText(text: "Episodes:", size: 22, weight: .bold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 20)
                        
                        AvenirText(
                            text: character.episode
                                .compactMap { episodeNumber(from: $0) }
                                .map { String($0) }
                                .joined(separator: ", "),
                            size: 22, weight: .regular
                        )
                        .padding(.horizontal, 5)
                        .foregroundColor(Color.white)
                    }
                    
                    HStack {
                            AvenirText(text: "Created at\n(in API):", size: 21, weight: .bold)
                                .frame(width: 105, alignment: .leading)
                                .foregroundColor(Color.white)
                                .padding(.horizontal,20)
                            AvenirText(text: character.formattedCreatedDate, size: 22, weight: .regular)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                }
                .background(Color("darkblue1"))
            }
            .background(Color("darkblue1"))
            
            
        }
        .background(Color("darkblue1"))
        
    }
    
}




struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacter = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Origin(name: "Earth (C-137)", url: ""),
            location: LocationStruct(name: "Earth (Replacement Dimension)", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/1"],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )
        CharacterDetailView(viewModel: CharacterDetailViewModel(), character: sampleCharacter)
    }
}

