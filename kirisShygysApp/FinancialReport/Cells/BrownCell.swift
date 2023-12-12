//
//  BrownCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import UIKit
import SnapKit

class BrownCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Financial freedom"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let moneyQuotes = [
        "Genius is born--not paid. Oscar Wilde",
        "A banker is a fellow who lends you his umbrella when the sun is shining, but wants it back the minute it begins to rain.Mark Twain",
        "An investment in knowledge always pays the best interest. Benjamin Franklin",
        "Money speaks sense in a language all nations understand. Aphra Behn",
        "Always borrow money from a pessimist. He won’t expect it back. Oscar Wilde",
        "A successful man is one who makes more money than his wife can spend. A successful woman is one who can find such a man. Lana Turner",
        "Liking money like I like it, is nothing less than mysticism. Money is a glory. Salvador Dali",
        "The greatest good you can do for another is not just share your riches, but to reveal to him his own. Benjamin Disraeli",
        "He who will not economize will have to agonize. Confucius",
        "Where large sums of money are concerned, it is advisable to trust nobody. Agatha Christie",
        "Your life is worth much more than gold. Bob Marley",
        "It is better to have a permanent income than to be fascinating. Oscar Wilde",
        "Money spent on the brain, is never spent in vain."
       ]
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        displayRandomMoneyQuote()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - set up views
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "lightBrown")
        contentView.addSubview(quoteLabel)
    }
    //MARK: - Actions
    
    func displayRandomMoneyQuote() {
           let randomIndex = Int.random(in: 0..<moneyQuotes.count)
           quoteLabel.text = moneyQuotes[randomIndex]
       }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        quoteLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
