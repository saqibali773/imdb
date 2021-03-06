//
//  Int.swift
//  imdb
//
//  Created by Saqib Ali on 18/04/2022.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber.init(value: self)) ?? ""
    }
}
