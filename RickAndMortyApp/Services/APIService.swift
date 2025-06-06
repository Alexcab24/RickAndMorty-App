//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation

class APIService {
    func fetchCharacters() async throws -> [Character] {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
}
