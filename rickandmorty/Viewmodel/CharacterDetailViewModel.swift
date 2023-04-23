//
//  CharacterDetailViewModel.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//

import Foundation
import SwiftUI
import Combine

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?

    // Burada API servisini çağırarak seçili karakterin detaylarını alacak bir fonksiyon oluşturulacaktır.
    func fetchCharacterDetails(id: Int) {
        // API servisini çağır ve sonucu character değişkenine ata.
    }
}
