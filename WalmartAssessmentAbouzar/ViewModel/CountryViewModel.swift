//
//  CountryViewModel.swift
//  WalmartAssessmentAbouzar
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation



class ViewModel {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    var countries = [Country]()
    var filteredResults = [Country]()
    var onDataFetched: (() -> Void)?
    
    func fetchData() async throws {
        
        do{
            let request = GetCountriesRequest()
            countries = try await apiClient.fetchData(request)
            onDataFetched?()
        }
        

    }
}

extension ViewModel {
    func filterResults(byString text: String) {
        let searchText = text.lowercased()
        filteredResults = countries.filter { country in
            guard let countryName = country.name?.lowercased(), let capitalName = country.capital?.lowercased() else { return false }
            return countryName.hasPrefix(searchText) || capitalName.hasPrefix(searchText)
        }
    }
}
