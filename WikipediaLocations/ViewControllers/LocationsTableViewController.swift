//
//  LocationsTableViewController.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit
import Combine

class LocationsTableViewController: UITableViewController {

    private var locations: [Location] = []
    private var cancellables: Set<AnyCancellable> = .init()
    
    var viewModel: LocationsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        viewModel?.fetchLocations()
    }
    
    private func bindToViewModel() {
        viewModel?.$locations
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] locations in
                self.locations = locations
                self.tableView.reloadData()
            }.store(in: &cancellables)
        
        // TODO: error handling + loading
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
