//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Alex on 8/6/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let id: Int
    @StateObject private var viewModel = CharacterDetailViewModel()

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.2)
            } else if let character = viewModel.character {
                ScrollView {
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                        startPoint: .bottom,
                                        endPoint: .center
                                    )
                                )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 300)
                        }

                        VStack(alignment: .leading, spacing: 16) {
                            Text(character.name)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.primary)

                            InfoRow(icon: "person", label: "Gender", value: character.gender)
                            InfoRow(icon: "leaf", label: "Specie", value: character.species)
                            InfoRow(icon: "globe", label: "Origin", value: character.origin.name)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding([.horizontal, .bottom])
                    }
                }
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Character Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadCharacter(id: id)
        }
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }

            Spacer()
        }
    }
}
