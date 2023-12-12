//
//  FinancialReportViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import UIKit
import SnapKit

final class FinancialReportViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var presenter = FinancialReportPresenter()
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        collectionView.reloadData()
        setupPresenter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(GreenCell.self, forCellWithReuseIdentifier: "GreenCell")
        collectionView.register(RedCell.self, forCellWithReuseIdentifier: "RedCell")
        collectionView.register(BrownCell.self, forCellWithReuseIdentifier: "BrownCell")
        
    }
    
    private func setupPresenter() {
        presenter = FinancialReportPresenter()
        presenter.view = self
        presenter.fetchFinancialReportData()
    }
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreenCell", for: indexPath) as! GreenCell
            
            cell.totalIncomeUpdateHandler = { totalIncome in
            cell.updateTotalIncomeForCurrentMonth(totalIncome)
            }
            
            cell.biggestIncomeUpdateHandler = { amount, category in
            cell.updateBiggestIncome(amount: amount, category: category)
            }
            
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RedCell", for: indexPath) as! RedCell
            
            cell.totalExpenseUpdateHandler = { [weak self] totalExpense in
                self?.updateTotalExpenseForCurrentMonth(totalExpense)
                print("Total Expense Handler: \(totalExpense)")
            }
            cell.biggestExpenseUpdateHandler = { [weak self] amount, category in
                self?.updateBiggestExpense(amount: amount, category: category)
                print("Biggest Expense Handler: Amount - \(amount), Category - \(category)")
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrownCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}

extension FinancialReportViewController: FinancialReportViewProtocol {
    
    func updateTotalIncomeForCurrentMonth(_ totalIncome: String) {
        print("Total Income Update: \(totalIncome)")
        if let greenCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? GreenCell {
            greenCell.updateTotalIncomeForCurrentMonth(totalIncome)
        }
    }
    
    func updateBiggestIncome(amount: String, category: String) {
        print("Biggest Income Update: Amount - \(amount), Category - \(category)")
        if let greenCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? GreenCell {
            greenCell.updateBiggestIncome(amount: amount, category: category)
        }
    }
    
    func updateTotalExpenseForCurrentMonth(_ totalExpense: String) {
        print("Total Expense Update: \(totalExpense)")
        if let redCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as? RedCell {
            redCell.updateTotalExpenseForCurrentMonth(totalExpense)
        }
    }

    func updateBiggestExpense(amount: String, category: String) {
        print("Biggest Expense Update: Amount - \(amount), Category - \(category)")
        if let redCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as? RedCell {
            redCell.updateBiggestExpense(amount: amount, category: category)
        }
    }
}

