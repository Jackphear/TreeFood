//
//  HomeModel.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/21.
//

import Foundation
import HandyJSON

// MARK: - 主页面所有数据
struct HomeData: HandyJSON {
    // 菜品
    let dishes = [Dishes]()
    // 营养补给
    let nutritionalSupplement = [NutritionalSupplement]()
    // 建议补充
    let suggestSupplement = SuggestSupplement()
    let favorite = Preference()
}

// MARK: - 所有菜品
struct Dishes: HandyJSON {
    
    let imageName = ""
    let speciesName = ""
    let content = [Dish]()
}

// MARK: - 菜
struct Dish: HandyJSON {
    
    let name = ""
    let image = ""
    // 描述
    let description = ""
    // 食材
    let ingredients = [Ingredient]()
    // 总卡路里
    let totalCaloris: Int = 200
}

// MARK: - 食材
struct Ingredient: HandyJSON {
    let image = ""
    let name = ""
    // 用量
    let dosage = ""
    let calorisNumber: Int = 43
}

// MARK: - 营养补给
struct NutritionalSupplement: HandyJSON {
    let categoryName = ""
    let supplements = [Supplement]()
}

// MARK: - 补给
struct Supplement: HandyJSON {
    let image = ""
    let name = ""
    let description = ""
    // 用法
    let usage = ""
    // 注意事项
    let precautions = ""
    // 热度
    let heat: Int = 4396
    // 评星
    let star: Int = 3
}

// MARK: - 建议补充
struct SuggestSupplement: HandyJSON {
    let supplements = [Supplement]()
}

// MARK: - 喜爱
struct Preference: HandyJSON {
    let dishes = [Dish]()
}

// MARK: - 背包食材
struct BagFood {
    let name: String
    let caloris: Int
}
