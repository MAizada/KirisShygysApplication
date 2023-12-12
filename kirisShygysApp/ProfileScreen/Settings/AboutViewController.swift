//
//  AboutViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.12.2023.
//

import UIKit
import SnapKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let aboutLabel = UILabel()
        aboutLabel.text = """
        Version 1.0

        Welcome to our financial management app!

        Our app is designed to help you effortlessly manage your income and expenses, providing you with a clear overview of your financial situation.

        Key Features:
        - Income Tracking: Easily log your sources of income to keep track of your earnings.
        - Expense Management: Categorize and monitor your spending habits for better financial planning.
        - Budgeting Tools: Set budgets and receive notifications to stay within your financial goals.
        - Insightful Reports: Visualize your financial data through comprehensive reports and charts.

        We are committed to continually improving our app to provide you with the best financial management experience. Your feedback is valuable to us; please feel free to reach out to us through the app's settings or contact us via [email/social media links].

        Thank you for choosing our app to take control of your finances!
        """
        aboutLabel.numberOfLines = 0
        aboutLabel.textAlignment = .left
        aboutLabel.font = UIFont.systemFont(ofSize: 10)

        view.addSubview(aboutLabel)

        aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
