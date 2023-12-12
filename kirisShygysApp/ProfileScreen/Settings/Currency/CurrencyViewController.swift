//
//  CurrencyViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.12.2023.
//

//import UIKit
//
//class CurrencyViewController: UIViewController, CurrencyView {
//    private var presenter: CurrencyPresenter!
//    
//    private let currencies: [String]
//    
//    init(currencies: [String]) {
//        self.currencies = currencies
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupPresenter()
//    }
//    
//    private func setupPresenter() {
//        let currencyConverter = CurrencyConverter(currencyRates: [:])
//        self.presenter = CurrencyPresenter(view: self, currencyConverter: currencyConverter)
//    }
//    
//    // Реализация метода из протокола CurrencyView
//    func displayConvertedAmount(_ amount: Double) {
//        // Обновление интерфейса с конвертированным значением
//    }
//    
//    // Метод, который вызывается при необходимости выполнить конвертацию
//    func performConversion() {
//        presenter.convert(amount: 100, fromCurrency: "USD", toCurrency: "KZT") // Пример вызова конвертации
//    }
// 
//}
