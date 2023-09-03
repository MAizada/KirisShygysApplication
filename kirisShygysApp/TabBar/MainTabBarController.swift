//
//  MainTabBarController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//
import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        generateTabBar()
        selectedIndex = 0
    }
    
    private func generateTabBar() {
        let homeViewController = HomeViewController()
        homeViewController.view.backgroundColor = .white
        let homeImage = UIImage(systemName: "house.fill")
        let homeTabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 0)
        homeViewController.tabBarItem = homeTabBarItem
        
        let transactionViewController = TransactionViewController()
        transactionViewController.view.backgroundColor = .white
        let transactionImage = UIImage(systemName: "arrow.left.arrow.right")
        let transactionTabBarItem = UITabBarItem(title: "Transaction", image: transactionImage, tag: 1)
        transactionViewController.tabBarItem = transactionTabBarItem
        
        let budgetViewController = BudgetViewController()
        budgetViewController.view.backgroundColor = .white
        let budgetImage = UIImage(systemName: "chart.pie.fill")
        let budgetTabBarItem = UITabBarItem(title: "Budget", image: budgetImage, tag: 3)
        budgetViewController.tabBarItem = budgetTabBarItem
        
        let profileViewController = ProfileViewController()
        profileViewController.view.backgroundColor = .white
        let profileImage = UIImage(systemName: "person.fill")
        let profileTabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 4)
        profileViewController.tabBarItem = profileTabBarItem
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let transactionNavigationController = UINavigationController(rootViewController: transactionViewController)
        let budgetNavigationController = UINavigationController(rootViewController: budgetViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
               
        viewControllers = [homeNavigationController, transactionNavigationController, budgetNavigationController, profileNavigationController]
           }
    }
    
extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
    

