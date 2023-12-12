//
//  CurrencyModel.swift
//  kirisShygysApp
//
//  Created by Aizada on 11.12.2023.
//
//
//import Foundation
//
//struct CurrencyConverter {
//    let currencyRates: [String: Double] 
//    
//    func convert(amount: Double, fromCurrency: String, toCurrency: String) -> Double? {
//        guard let fromRate = currencyRates[fromCurrency], let toRate = currencyRates[toCurrency] else {
//            return nil
//        }
//        return amount * (toRate / fromRate)
//    }
//}
