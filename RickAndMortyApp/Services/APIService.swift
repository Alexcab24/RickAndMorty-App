//
//  APIService.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation

class APIService {
    func fetchCharacters(_ name: String) async throws -> [Character] {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(encodedName)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return decoded.results
    }
    
    func fetchCharacter(_ id: Int) async throws -> Character {
        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Character.self, from: data)
        return decoded
    }
}
