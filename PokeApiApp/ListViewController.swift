//
//  ListViewController.swift
//  PokeApiApp
//
//  Created by Baki Hasan Ertürk on 25.03.2023.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemons = Pokemons()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pokemons.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goPokemonDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destination.pokemon = pokemons.pokemonArray[selectedIndexPath?.row ?? 0]
        }
    }
}
    
extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PokemonTableViewCell
        if indexPath.row == pokemons.pokemonArray.count-1 && pokemons.urlString.hasPrefix("https") {
            pokemons.getData {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        print("\(cell.pokemonName.text = pokemons.pokemonArray[indexPath.row].name)")
        return cell
    }
}
