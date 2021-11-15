//
//  AddModel.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/15.
//

import Foundation
import HandyJSON

// MARK: - DataClass
struct AddModel: HandyJSON {
    let eats = [AddFood]()
}


// MARK: - AddFood
struct AddFood: HandyJSON {
    var categoryName = ""
    var content = [Ingredient]()
}
// MARK: -背包食材
struct BagFood {
    let name:String
    let caloris:Int
}
