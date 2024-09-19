//
//  TableCellProtocol.swift
//  WalmartAssessmentAbouzar
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


