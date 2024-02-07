//
//  FirebaseManager.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.11.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let auth = Auth.auth()
    var allTransactions: [Transaction] = []
    
    private func configueFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    //MARK: - Users
    func createNewUser(_ data: LoginField, completion: @escaping (ResponseCode) -> () ) {
        
        auth.createUser(withEmail: data.email, password: data.password) { [weak self] result, error in
            
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let initialBalance: Double = 0.0
                    
                    let data: [String: Any] = ["email": email, "balance": initialBalance]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    completion(ResponseCode(code: 1))
                }
            } else {
                completion(ResponseCode(code: 0))
            }
        }
    }
    
    func authInApp(_ data: LoginField, completion: @escaping (AuthResponce) -> ()) {
        auth.signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            } else {
                if let result = result {
                    completion(.success)
                }
            }
        }
    }
    
    func getAllUsers(completion: @escaping ([CurrentUser]) -> ()) {
        
        guard let email = auth.currentUser?.email else { return }
        
        var currentUsers = [CurrentUser]()
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email)
            .getDocuments { snapshot, error in
                if error == nil {
                    
                    if let documents = snapshot?.documents {
                        for document in documents {
                            let data = document.data()
                            let userId = document.documentID
                            let email = data["email"] as! String
                            let balance = data["balance"] as? Double ?? 0.0
                            
                            currentUsers.append(CurrentUser(id: userId, email: email, balance: balance))
                        }
                    }
                    completion(currentUsers)
                }
            }
    }
    
    func getUsername(completion: @escaping (String?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let username = currentUser.displayName
            completion(username)
        } else {
            completion(nil)
        }
    }
    
    //MARK: - Logout
    public func logout(completion: @escaping (Result<(), Error>) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // MARK: - Transactions
    
    func saveTransaction(_ transaction: Transaction, completion: @escaping (Error?) -> Void) {
        let db = configueFB()
        
        let userId = Auth.auth().currentUser?.uid
        let transactionData: [String: Any] = [
            "userId": userId,
            "title": transaction.title,
            "description": transaction.description,
            "amount": transaction.amount,
            "date": transaction.date,
            "time": transaction.time,
            "type": transaction.type == .income ? "income" : "expense"
        ]
        
        db.collection("transactions").addDocument(data: transactionData) { error in
            if let error = error {
                print("Error adding transaction: \(error)")
                completion(error)
            } else {
                print("Transaction added successfully")
                completion(nil)
            }
        }
    }
    
    func loadTransactions(completion: @escaping ([Transaction]) -> Void) {
        let db = configueFB()
        var transactions: [Transaction] = []
        
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("transactions")
                .whereField("userId", isEqualTo: userId)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching transactions: \(error)")
                        completion([])
                    } else if let documents = snapshot?.documents {
                        var fetchedTransactions: [Transaction] = []
                        for document in documents {
                            let timestamp = document.data()["date"] as? Timestamp
                            let date = timestamp?.dateValue()
                            
                            let typeString = document.data()["type"] as? String ?? ""
                            let transactionType: TransactionType = typeString == "income" ? .income : .expense
                            
                            let transaction = Transaction(
                                title: document.data()["title"] as? String ?? "",
                                description: document.data()["description"] as? String ?? "",
                                amount: document.data()["amount"] as? String ?? "",
                                time: document.data()["time"] as? Date ?? Date(),
                                date: date ?? Date(),
                                type: transactionType
                            )
                            fetchedTransactions.append(transaction)
                        }
                        self.allTransactions.append(contentsOf: fetchedTransactions)
                        completion(fetchedTransactions)
                    }
                }
        }
    }
    
    func updateBalance(for userId: String, newBalance: Double, completion: @escaping (ResponseCode) -> Void) {
        let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(userId)
        
        userDocRef.updateData(["balance": newBalance]) { error in
            if let error = error {
                print("Error updating balance: \(error.localizedDescription)")
                completion(ResponseCode(code: 0))
            } else {
                print("Balance successfully updated in Firestore")
                completion(ResponseCode(code: 1))
            }
        }
    }
}


