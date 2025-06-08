//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Alex on 5/6/25.
//

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
    let species: String
    let gender: String
    let origin: Origin
}

struct Origin: Decodable {
    let name: String
}

struct CharacterResponse: Decodable {
    let results: [Character]
}
