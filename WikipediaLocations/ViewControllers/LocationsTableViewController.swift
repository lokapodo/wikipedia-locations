//
//  LocationsTableViewController.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit
import Combine

class LocationsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lonTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    private var locations: [Location] = []
    private var cancellables: Set<AnyCancellable> = .init()
    
    var viewModel: LocationsViewModel?
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.hidesWhenStopped = true
        
        bindToViewModel()
        viewModel?.fetchLocations()
    }
    
    // MARK: - Private
    
    private func bindToViewModel() {
        viewModel?.$locations
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] locations in
                self.locations = locations
                self.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel?.$error
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] error in
                if let error = error {
                    showErrorAlert(error)
                }
            }.store(in: &cancellables)
        
        viewModel?.$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isLoading in
                if isLoading {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    @IBAction func tapOnOpenWikipediaButton(_ sender: Any) {
        guard let latString = latTextField.text, let lat = Double(latString),
              let lonString = lonTextField.text, let lon = Double(lonString)
        else {
            print("Error occured: wrond lat lon format")
            return
        }
        
        viewModel?.openWikipedia(location: Location(lat: lat, lon: lon))
    }
    
    // FIXME: responsible for presentation?
    private func showErrorAlert(_ error: Error) {
        let title = "Error occurred"
        let message = error.localizedDescription
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
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
        viewModel?.openWikipedia(location: location)
    }

}
