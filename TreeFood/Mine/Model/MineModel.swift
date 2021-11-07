//
//  MineModel.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/3.
//

import Foundation
import HandyJSON

struct MineModel: HandyJSON {
    var backgroundImage = ""
    var userImage = ""
    var userName = ""
    var sex = ""
    var weight = ""
    var height = ""
    var birthday = ""
}

public enum editType {
    case sex
    case height
    case date
    case weight
}
