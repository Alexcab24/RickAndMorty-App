//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

import Foundation

struct CharacterResponse: Decodable {
    let results: [Character]
}

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
}

