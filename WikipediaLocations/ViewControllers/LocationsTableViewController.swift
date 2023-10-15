//
//  LocationsTableViewController.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    private var locations = [testLocation1, testLocation2, testLocation3]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLocations()
    }
    
    private func loadLocations() {
        let networkService = LocationsNetworkService(networkService: NetworkService())
        networkService.getLocations { result in
            switch result {
            case .success(let locations):
                self.locations = locations
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error occured: ", error.localizedDescription)
            }
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name // FIXME: deprecated
        cell.detailTextLabel?.text = "(\(location.lat); \(location.lon))"
        return cell
    }

    // MARK: -  UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let location = locations[indexPath.row]
        openWikipedia(location: location)
    }
    
    private func openWikipedia(location: Location) {
        // TODO
    }

}
