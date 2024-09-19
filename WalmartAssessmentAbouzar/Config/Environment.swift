//
//  Environment.swift
//  WalmartAssessmentAbouzar
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation


public enum Environment {
    enum Keys {
        static let countriesUrl = "COUNTRIES_BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else { fatalError("Config plist not found") }
        return dict
    }()
    
    static let countriesUrl: URL = {
        guard let baseUrl = Environment.infoDictionary[Keys.countriesUrl] as? String else { fatalError("Countries URL is not defined in plist") }
        
        print(baseUrl)
        return URL(string: baseUrl)!
    }()
    
}
