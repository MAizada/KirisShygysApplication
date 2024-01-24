//
//  EditContract.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.01.2024.
//

import Foundation
import UIKit

protocol EditViewProtocol: AnyObject {
    func updateProfileInfo(name: String, avatar: UIImage?)
}

protocol EditPresenterProtocol {
    func saveChanges(name: String, avatar: UIImage?)
}
  

