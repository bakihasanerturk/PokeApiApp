//
//  DetailViewController.swift
//  PokeApiApp
//
//  Created by Baki Hasan Ertürk on 25.03.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonDetailImage: UIImageView!
    @IBOutlet weak var pokemonDetailName: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonDetailName.text = pokemon.name
        
        let pokemonDetail = PokemonDetail()
        pokemonDetail.urlString = pokemon.url
        pokemonDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(pokemonDetail.weight)"
                self.heightLabel.text = "\(pokemonDetail.height)"
                
                guard let url = URL(string: pokemonDetail.imageURL) else {return}
                do{
                    let data = try Data(contentsOf: url)
                    self.pokemonDetailImage.image = UIImage(data: data)
                }catch{
                    print("Error")
                }
            }
            
        }
    
    }
}
