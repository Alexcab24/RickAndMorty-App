//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = CharactersViewModel()
  
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(id: character.id)) {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: character.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .overlay(
                                        ProgressView()
                                    )
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .shadow(radius: 3)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(character.name)
                                    .font(.headline)
                                Text(character.species)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Characters")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search characters"
            )
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}

#Preview {
    ListView()
}
