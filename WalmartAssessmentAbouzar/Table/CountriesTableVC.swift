//
//  ViewController.swift
//  WalmartAssessmentAbouzar
//
//  Created by Abouzar Moradian on 9/19/24.
//

import UIKit

class CountriesTableVC: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel(apiClient: APIClient(apiEndpoint: Environment.countriesUrl))
    let searchController = UISearchController(searchResultsController: nil)
    
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text ?? "").isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
       
        Task{
            do{
                try await viewModel.fetchData()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch {
                DispatchQueue.main.async {
                    self.presentErrorAlert(error: error)
                }
            }
        }
    }


}

// MARK: - Table view data source
extension CountriesTableVC: UITableViewDataSource {
    
   

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredResults.count
        }
        return viewModel.countries.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = isFiltering ? viewModel.filteredResults[indexPath.row] : viewModel.countries[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as? CountryTableViewCell {
            cell.configure(with: country)
            return cell
        }
        return UITableViewCell()
    }
}


extension CountriesTableVC {
    
    func presentErrorAlert(error: Error?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "An error has occurred.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
   
    
    
    func setupSearchController ()  {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Enter Name or Capital"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
}

extension CountriesTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.filterResults(byString: searchText)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

