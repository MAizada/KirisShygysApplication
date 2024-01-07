//
//  ProfileViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation
protocol ProfileViewProtocol: AnyObject {
    func showUserName(_ userName: String)
}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    func getUserName()
    func confirmLogout()
}
