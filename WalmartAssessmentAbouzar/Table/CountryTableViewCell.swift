//
//  CountryTableViewCell.swift
//  WalmartAssessmentAbouzar
//
//  Created by Abouzar Moradian on 9/19/24.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    let labelStack = UIStackView()
    let countryLabel = UILabel()
    let capitalLabel = UILabel()
    let abbrvLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setupViews() {
        countryLabel.numberOfLines = 0
        capitalLabel.numberOfLines = 0
        abbrvLabel.numberOfLines = 1
        
        labelStack.alignment = .fill
        labelStack.distribution = .fill
        labelStack.axis = .vertical
        
        labelStack.addArrangedSubview(countryLabel)
        labelStack.addArrangedSubview(capitalLabel)
        
        self.addSubview(labelStack)
        self.addSubview(abbrvLabel)
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        abbrvLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.safeAreaLayoutGuide
        labelStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        labelStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12).isActive = true
        labelStack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: abbrvLabel.leadingAnchor, constant: 12).isActive = true
        
        abbrvLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12).isActive = true
        abbrvLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12).isActive = true
        abbrvLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12).isActive = true
        abbrvLabel.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }

    func configure(with country: Country) {
        self.countryLabel.text = "\(country.name ?? "Missing Country Name"), \(country.region ?? "N/A")"
        self.capitalLabel.text = country.capital ?? "N/A"
        self.abbrvLabel.text = country.code ?? "N/A"
    }
    
    override func prepareForReuse() {
        countryLabel.text = ""
        capitalLabel.text = ""
        abbrvLabel.text = ""
    }
}

