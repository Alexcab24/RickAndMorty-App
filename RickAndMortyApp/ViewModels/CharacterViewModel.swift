//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Alex on 8/6/25.
//

import Foundation
import Combine

@MainActor
class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let api = APIService()

    func loadCharacter(id: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetched = try await api.fetchCharacter(id)
            character = fetched
        } catch {
            character = nil
            errorMessage = "An error occurred while loading character."
        }

        isLoading = false
    }
}
