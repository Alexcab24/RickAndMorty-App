//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation
import Combine

@MainActor
class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    private let api = APIService()
    
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()

    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                Task {
                    await self?.loadCharacters(name: text)
                }
            }
            .store(in: &cancellables)
    }

    
    
    
    func loadCharacters(name: String = "") async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        do {
            let fetched = try await api.fetchCharacters(searchText)
            await MainActor.run {
                self.characters = fetched
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.characters = []
                self.errorMessage = "An error occurred while loading characters."
                self.isLoading = false
            }
        }
    }
}
