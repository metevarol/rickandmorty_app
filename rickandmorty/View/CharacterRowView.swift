//
//  CharacterRowView.swift
//  rickandmorty
//
//  Created by Mete Varol on 20.04.2023.
//

import SwiftUI

struct CharacterRowView: View {
    @State var label: String
    @State var photo: String
    @State var gender: String
    var body: some View {
        
        ZStack {
            
            HStack{
               Spacer()
                AsyncImage(url: URL(string: photo)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("green1"), lineWidth: 5))
                }
                placeholder: {
                    Color.gray
                }
                .frame(width: 100, height: 100, alignment: .topLeading)

                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Image(gender)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                Spacer()
            }
            
            HStack{
                
                Spacer()
                Spacer()
                Spacer()
                
               
                VStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 8) {
                        ForEach(label.split(separator: " "), id: \.self) { word in
                            Text(word)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                        }
                    }

                        
                    
                    Spacer()
                   
                    
                   
                }
                
                
                Spacer()
                Spacer()
                
            }
            
            Spacer()
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("darkblue1"))
                .frame(width: 370, height:135)
                
        )
        
        
    }
    
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(label: "deneme",photo:"https://rickandmortyapi.com/api/character/avatar/2.jpeg",gender:"Male")
    }
}
