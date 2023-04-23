import Foundation
import SwiftUI
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private var networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var noCharacters: Bool = false // ***
    
    func clearCharacters() {
            self.characters = []
        }

    func updateCharacters(for location: Location?) {
        if let locationUrl = location?.url {
            fetchCharacters(from: locationUrl)
        } else {
            characters = []
        }
    }

    private func fetchCharacters(from locationUrl: String) {
        networkManager.fetchCharacterIds(from: locationUrl)
            .flatMap { characterIds in
                self.networkManager.fetchCharacters(with: characterIds)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching characters: \(error.localizedDescription)")
                    self.noCharacters = true 
                }
            }, receiveValue: { [weak self] characters in
                self?.characters = characters
                self?.noCharacters = characters.isEmpty // ***
            })
            .store(in: &cancellables)
    }
}
