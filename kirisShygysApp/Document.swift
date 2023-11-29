//
//  Document.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.11.2023.
//

import Foundation

enum AuthResponce {
    case success, noVerify, error
}

struct LoginField {
    var email: String
    var password: String
}

struct ResponseCode {
    var code: Int
}

struct CurrentUser {
    var id: String
    var email: String
    //var balance: 
}

struct User {
    let name: String
    let email: String
    let password: String
    let transactions: [Transaction]
    let categories: [Categories]
}

struct Transaction {
    //  let image: UIImage
    let title: String
    let description: String
    let amount: String
    let time: Date
    let date: Date
    let type: TransactionType
}

enum TransactionType {
    case income
    case expense
}

struct Transactions {
    let categoryId: String
    let sum: Double
    let date: String
    let description: String
    let transactionType: TransactionType
    let currency: Currency
}

struct Currency {
    let sign: String
    let shortName: String
}

struct Categories {
    
    let name: String
    let imageUrl: String
    let categoryId: String
    let type: TransactionType
}

struct Category {
    static let expenses = [
        Categories(name: "Shopping", imageUrl: "shoppingImageURL", categoryId: "shoppingCategoryID", type: .expense),
           Categories(name: "Food", imageUrl: "foodImageURL", categoryId: "foodCategoryID", type: .expense),
           Categories(name: "Transportations", imageUrl: "transportationsImageURL", categoryId: "transportationsCategoryID", type: .expense),
           Categories(name: "Subscription", imageUrl: "subscriptionImageURL", categoryId: "subscriptionCategoryID", type: .expense),
    ]
       static let incomes = [
           Categories(name: "Salary", imageUrl: "salaryImageURL", categoryId: "salaryCategoryID", type: .income),
        Categories(name: "Bonus", imageUrl: "bonusImageURL", categoryId: "bonusCategoryID", type: .income),
    Categories(name: "Other", imageUrl: "otherImageURL", categoryId: "otherCategoryID", type: .income)
   ]
}
