//
//  Pokemons.swift
//  PokeApiApp
//
//  Created by Baki Hasan Ertürk on 25.03.2023.
//

import Foundation

class Pokemons{
    
    private struct Returned: Codable{
        var count:Int
        var next:String?
        var results: [Pokemon]
        
    }
    
    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=081imit=20"
    var pokemonArray: [Pokemon] = []
    var isFetching = false
    
    func getData(completed: @escaping()->()) {
        guard !isFetching else{
            return
        }
        
        isFetching = true
        print("Accesing url: \(urlString)")
        
        // Create a url
        
        guard let url = URL(string: urlString) else{
            print("Error: \(urlString)")
            return
        }
        
        // Create a Session
        
        let session = URLSession.shared
        
        // Get data task Method
        
        let task = session.dataTask(with: url) { ( data, response, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }
            do{
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("what was returned: \(returned)")
                self.pokemonArray = self.pokemonArray + returned.results
                self.urlString = returned.next ?? ""
                self.count = returned.count
            }catch{
                print("JSon Error:")
            }
            self.isFetching = false
            completed()
        }
        task.resume()
    }
}
