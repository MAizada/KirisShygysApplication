//
//  MainTabBarController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        generateTabBar()
        selectedIndex = 0
    }
    
    private func generateTabBar() {
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        let homeViewController = HomeViewController()
        let homeImage = UIImage(systemName: "house.fill")
        let homeTabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        homeViewController.tabBarItem = homeTabBarItem
        
        let transactionViewController = TransactionViewController()
        let transactionImage = UIImage(systemName: "arrow.left.arrow.right")
        let transactionTabBarItem = UITabBarItem(title: "Transaction", image: transactionImage, tag: 1)
        transactionViewController.tabBarItem = transactionTabBarItem
        
        let budgetViewController = BudgetViewController()
        let budgetImage = UIImage(systemName: "chart.pie.fill")
        let budgetTabBarItem = UITabBarItem(title: "Budget", image: budgetImage, tag: 3)
        budgetViewController.tabBarItem = budgetTabBarItem
        
        let profileViewController = ProfileViewController()
        let profileImage = UIImage(systemName: "person.fill")
        let profileTabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 4)
        profileViewController.tabBarItem = profileTabBarItem
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let transactionNavigationController = UINavigationController(rootViewController: transactionViewController)
        let budgetNavigationController = UINavigationController(rootViewController: budgetViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        let iconColor = UIColor(named: "brown")
        
        let buttonSize: CGFloat = 60
        let image = UIImage(systemName: "plus.circle.fill")?.withTintColor(iconColor!, renderingMode: .alwaysOriginal)
        let resizedImage = image?.resized(to: CGSize(width: buttonSize, height: buttonSize))
        
        let secondImage = UIImage(systemName: "xmark.circle.fill")?.withTintColor(iconColor!, renderingMode: .alwaysOriginal)
        let secondResizedImage = secondImage?.resized(to: CGSize(width: buttonSize, height: buttonSize))
        
        let plusButton = UIButton(type: .custom)
        plusButton.setImage(resizedImage, for: .normal)
        plusButton.setImage(secondResizedImage, for: .selected)
        plusButton.backgroundColor = .clear
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        let tabBarHeight = tabBar.frame.height
        let tabBarWidth = tabBar.frame.width
        let plusButtonSize: CGFloat = 70
        
        plusButton.frame = CGRect(x: (tabBarWidth - buttonSize) / 2, y: tabBarHeight - buttonSize - 23, width: buttonSize, height: buttonSize)
        
        viewControllers = [homeNavigationController, transactionNavigationController, budgetNavigationController, profileNavigationController]
        
        tabBar.addSubview(plusButton)
    }
    
    @objc private func plusButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            showIncomeAndExpenseButtons()
        } else {
            hideIncomeAndExpenseButtons()
        }
    }
    
    private func showIncomeAndExpenseButtons() {
        let incomeButton = UIButton(type: .custom)
        incomeButton.setImage(UIImage(named: "incomeWhite"), for: .normal)
        incomeButton.backgroundColor = UIColor(named: "green")
        incomeButton.setTitleColor(.white, for: .normal)
        incomeButton.layer.cornerRadius = 28
        incomeButton.addTarget(self, action: #selector(incomeButtonTapped), for: .touchUpInside)
        
        let expenseButton = UIButton(type: .custom)
        expenseButton.setImage(UIImage(named: "expenseWhite"), for: .normal)
        expenseButton.backgroundColor = UIColor(named: "red")
        expenseButton.setTitleColor(.white, for: .normal)
        expenseButton.layer.cornerRadius = 28
        expenseButton.addTarget(self, action: #selector(expenseButtonTapped), for: .touchUpInside)
        
        view.addSubview(incomeButton)
        view.addSubview(expenseButton)
        
        incomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(-128)
            make.leading.equalTo(92)
            make.width.height.equalTo(56)
        }
        
        expenseButton.snp.makeConstraints { make in
            make.bottom.equalTo(-128)
            make.trailing.equalTo(-92)
            make.width.height.equalTo(56)
        }
        view.layoutIfNeeded()
    }
    
    private func hideIncomeAndExpenseButtons() {
        for subview in view.subviews {
            if subview is UIButton {
                subview.removeFromSuperview()
            }
        }
    }
    
    @objc private func incomeButtonTapped() {
        let incomeViewController = IncomeViewController()
        
        let incomeNavigationController = UINavigationController(rootViewController: incomeViewController)
        self.present(incomeNavigationController, animated: true, completion: nil)
    }
    
    @objc private func expenseButtonTapped() {
        let expenseViewController = ExpenseViewController()
        
        let expenseNavigationController = UINavigationController(rootViewController: expenseViewController)
        self.present(expenseNavigationController, animated: true, completion: nil)
    }
}
    extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

    extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}

