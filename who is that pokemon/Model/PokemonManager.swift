//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by User on 14/12/22.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel])
    func didFailWithError(error: Error)
}

struct PokemonManager {
    let pokemonURL: String = "https://pokeapi.co/api/v2/pokemon?limit=898"
    var delegate: PokemonManagerDelegate?
       
    func fetchPokemon() {
        performRequest(with: pokemonURL)
    }
    
    private func performRequest(with urlString: String) {
        // 1. Create/get URL
        if let url = URL(string: urlString) { // Al mismo tiempo que declaras una variable verificas que se declaró correctamente, validas
            // 2. Create the URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData) {
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    // Swift recobe un JSON, swift no sabe como manejar esto, el decode lo traduce
    private func parseJSON(pokemonData: Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonData)
            
            // Aquí ya se consumen los datos de la API
            let pokemon = decodeData.results?.map {
                // PokemonModel is how I wanna manage my information
                PokemonModel(name: $0.name ?? "", imageURL: $0.url ?? "")
            }
            return pokemon
        } catch {
            return nil
        }
    }
}
