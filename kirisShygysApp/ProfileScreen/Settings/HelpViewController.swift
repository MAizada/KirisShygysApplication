//
//  HelpViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.12.2023.
//

import UIKit
import SnapKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let helpLabel = UILabel()
        helpLabel.text = """
        Need help?

        - Check our FAQs for answers to common questions.
        - Contact us at support@example.com for assistance.
        - Visit our website for video tutorials and guides.
        - Follow us on social media for updates and tips.

        We're here to make your experience better!
        """
        helpLabel.numberOfLines = 0
        helpLabel.textAlignment = .left
        helpLabel.font = UIFont.systemFont(ofSize: 10)
        helpLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(helpLabel)

        helpLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}
