//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.characters) { character in
                HStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())

                    Text(character.name)
                        .font(.headline)
                }
            }
            .navigationTitle("Personajes")
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}


#Preview {
    ContentView()
}
