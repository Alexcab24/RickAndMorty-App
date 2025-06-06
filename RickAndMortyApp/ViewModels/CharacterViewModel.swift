//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation
import Combine

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var searchText: String = ""
    private let api = APIService()
    
    
    private var cancellables = Set<AnyCancellable>()
       private let apiService = APIService()

    
    init() {
           // Escuchar cambios en el texto de búsqueda con debounce
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
        do {
            characters = try await api.fetchCharacters(searchText)
        } catch {
            print("Error: \(error)")
        }
    }
}
