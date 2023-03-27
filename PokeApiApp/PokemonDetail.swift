//
//  PokemonDetail.swift
//  PokeApiApp
//
//  Created by Baki Hasan Ertürk on 26.03.2023.
//

import Foundation

class PokemonDetail{
    
    private struct Returned: Codable {
        var height:Double
        var weight:Double
        var sprites:Sprites
    }
    
    private struct Sprites: Codable{
        var front_default:String?
    }
    
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var urlString = ""
    
    func getData(completed: @escaping()->()){
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
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default ?? ""
                
            }catch{
                print("JSon Error:")
            }
            completed()
        }
        task.resume()
    }
}


