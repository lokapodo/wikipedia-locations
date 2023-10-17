//
//  LocationsTableViewController.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit
import Combine

class LocationsViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var lonTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.hidesWhenStopped = true
        }
    }

    private var locations: [Location] = []
    private var cancellables: Set<AnyCancellable> = .init()
    
    var viewModel: LocationsViewModel?
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            print("Error occurred: wrong entered lat lon format")
            showErrorAlert(LocationError.wrongLatLonFormat)
            return
        }
        
        viewModel?.openWikipedia(location: Location(lat: lat, lon: lon))
    }
    
    // MARK: - Error handling
    
    private func showErrorAlert(_ error: Error) {
        let title = "Error"
        let message = self.description(for: error)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.accessibilityIdentifier = "error_alert"
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    private func description(for error: Error) -> String {
        switch error {
        case LocationError.wrongLatLonFormat:
            return "Invalid latitude and longitude format. Please enter it in the correct format, example: 38.736946 and -9.142685"
        default:
            return error.localizedDescription
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
        viewModel?.openWikipedia(location: location)
    }

}
