//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private let api = APIService()

    func loadCharacters() async {
        do {
            characters = try await api.fetchCharacters()
        } catch {
            print("Error: \(error)")
        }
    }
}
