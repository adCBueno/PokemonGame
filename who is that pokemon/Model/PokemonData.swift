//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by User on 14/12/22.
//

import Foundation

// Model of API para la entrada, lo que nos llegará

// MARK: - PokemonData
struct PokemonData: Codable {
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let url: String?
}
