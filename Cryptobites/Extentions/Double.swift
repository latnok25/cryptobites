//
//  Double.swift
//  Cryptobites
//
//  Created by VENOM on 3/24/23.
//

import Foundation

extension Double {
    /// helps convert a doubble to 2 to 6 decimal places
    private var CurrencyFormatter2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func AsCurrencyWithDecimals2()-> String {
        let number = NSNumber(value: self)
        
        return CurrencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// helps convert a doubble to 2 to 6 decimal places
    private var CurrencyFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func AsCurrencyWithDecimals()-> String {
        let number = NSNumber(value: self)
        
        return CurrencyFormatter.string(from: number) ?? "$0.00"
    }
    
    func AsNumberString()-> String {
        return String(format: "%.2F", self)
    }
    
    func AsPercentString()-> String {
        return AsNumberString() + "%"
    }
}
