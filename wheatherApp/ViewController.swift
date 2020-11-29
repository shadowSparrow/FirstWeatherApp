//
//  ViewController.swift
//  wheatherApp
//
//  Created by Alexander Romanenko on 26.06.2020.
//  Copyright © 2020 Alexander Romanenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let searchBar = UISearchBar()
    let cityLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchBarInit
        searchBar.delegate = self
        self.searchBar.placeholder = "enter the name of the city"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBarConstraint()
        
        //CityLabelInit
        self.cityLabel.backgroundColor = .green
        self.cityLabel.textColor = .red
        self.cityLabel.textAlignment = .center
        self.cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        cityLabelConstraints()
        
        //TemperatureLabelInit
        self.temperatureLabel.backgroundColor = .red
        self.temperatureLabel.textColor = .green
        self.temperatureLabel.textAlignment = .center
        self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temperatureLabel)
        temperatureLabelConstraints()
    }
    
    func searchBarConstraint() {
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    
    func cityLabelConstraints() {
        cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cityLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 50).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func temperatureLabelConstraints() {
        temperatureLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 50).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension ViewController: UISearchBarDelegate {
    
    struct Json: Decodable {
        var location: location
        var current: current
    }
    struct location: Decodable {
         var name: String
    }
    struct current: Decodable {
        var temp_c: Int
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=ab6d99f4882f4a5b9fe134340200207&q=\(searchBar.text!)"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let local = try JSONDecoder().decode(Json.self, from: data!)
                DispatchQueue.main.async {
                self.cityLabel.text = local.location.name
                self.temperatureLabel.text = "\(local.current.temp_c)"
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
}
}
