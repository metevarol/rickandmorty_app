
//
//  Created by Mete Varol on 17.04.2023.
//
import Foundation
import Combine

class NetworkManager {
    private let baseURL = "https://rickandmortyapi.com/api"
    
    func fetchLocations() -> AnyPublisher<[Location], Error> {
        let url = URL(string: "\(baseURL)/location")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: APIResponse<Location>.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
    func fetchCharacterIds(from locationUrl: String) -> AnyPublisher<[Int], Error> {
           guard let url = URL(string: locationUrl) else {
               return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
           }

           return URLSession.shared.dataTaskPublisher(for: url)
               .tryMap { response in
                   guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                       throw URLError(.badServerResponse)
                   }
                   return response.data
               }
               .decode(type: Location.self, decoder: JSONDecoder())
               .map { $0.residents.map { Int($0.split(separator: "/").last!)! } }
               .eraseToAnyPublisher()
       }
    
    func fetchCharacters(with characterIds: [Int]) -> AnyPublisher<[Character], Error> {
        let charactersUrl = "\(baseURL)/character/\(characterIds.map { String($0) }.joined(separator: characterIds.count > 1 ? "," : ""))"
        
        guard let url = URL(string: charactersUrl) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .flatMap { data -> AnyPublisher<[Character], Error> in
                if characterIds.count > 1 {
                    return Just(data)
                        .decode(type: [Character].self, decoder: JSONDecoder())
                        .mapError { error in
                            print("Error decoding multiple characters: \(error.localizedDescription)")
                            return error
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Just(data)
                        .decode(type: Character.self, decoder: JSONDecoder())
                        .map { [$0] }
                        .mapError { error in
                            print("Error decoding single character: \(error.localizedDescription)")
                            return error
                        }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }


    
    struct APIResponse<T: Codable>: Codable {
        let results: [T]
    }
}
