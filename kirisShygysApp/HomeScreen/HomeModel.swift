//
//  HomeModel.swift
//  kirisShygysApp
//
//  Created by Aizada on 31.10.2023.
//

import Foundation

struct HomeModel {
    var month: String
    var accountBalance: String
    var money: String
}

enum Period {
    case today
    case thisWeek
    case thisMonth
    case thisYear
}
