//
//  CurrencyPresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 11.12.2023.
//

//import Foundation
//
//class CurrencyPresenter {
//    weak var view: CurrencyView?
//    private let currencyConverter: CurrencyConverter
//
//    init(view: CurrencyView, currencyConverter: CurrencyConverter) {
//        self.view = view
//        self.currencyConverter = currencyConverter
//    }
//
//    func convert(amount: Double, fromCurrency: String, toCurrency: String) {
//        if let convertedAmount = currencyConverter.convert(amount: amount, fromCurrency: fromCurrency, toCurrency: toCurrency) {
//            view?.displayConvertedAmount(convertedAmount)
//        } else {
//            // Обработка ошибки конвертации
//            print("Error converting currencies")
//        }
//    }
//
//    func fetchCurrencyRates() {
//        let baseURL = "https://open.er-api.com/v6/latest"
//        let appID = "YOUR_API_KEY" // Замените на ваш API ключ
//
//        // Формируем URL с параметрами запроса для получения курсов валют
//        let symbols = "KZT,USD,RUB,EUR" // Валюты, которые вас интересуют
//        let urlString = "\(baseURL)?symbols=\(symbols)&app_id=\(appID)"
//
//        if let url = URL(string: urlString) {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    print("Invalid response")
//                    return
//                }
//
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        if let rates = (json as? [String: Any])?["rates"] as? [String: Double] {
//                            // Здесь rates содержит курсы валют
//                            let tengeRate = rates["KZT"]
//                            let dollarRate = rates["USD"]
//                            let rubleRate = rates["RUB"]
//                            let euroRate = rates["EUR"]
//                            print("Tenge Rate: \(tengeRate ?? 0)")
//                            print("Dollar Rate: \(dollarRate ?? 0)")
//                            print("Ruble Rate: \(rubleRate ?? 0)")
//                            print("Euro Rate: \(euroRate ?? 0)")
//                        }
//                    } catch {
//                        print("Error decoding JSON: \(error)")
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//}
