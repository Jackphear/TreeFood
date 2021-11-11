//
//  File.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/11.
//

import Foundation
import HandyJSON

// MARK: - Recorder

struct Recorder: HandyJSON {
    let code: Int = 0
    let data = RecoderDataClass()
}

// MARK: - DataClass

struct RecoderDataClass: HandyJSON {
    let today = Today()
    let old_datas = [Today]()

    enum CodingKeys: String, CodingKey {
        case today
        case oldDatas = "old_datas"
    }
}

// MARK: - Today

struct Today: HandyJSON {
    let time = ""
    let body: Body = Body()
    let today_attract = [TodayAttract]()
    let water_attract = WaterAttract()

    enum CodingKeys: String, CodingKey {
        case body
        case todayAttract = "today_attract"
        case waterAttract = "water_attract"
    }
}

// MARK: - Body

struct Body: HandyJSON {
    let height = 0
    let weight = 0
    let attract = 0
    let rest = 0
}

// MARK: - TodayAttract

struct TodayAttract: HandyJSON {
    let name: String = ""
    let img: String = ""
    let content = [RecorderContent]()
}

// MARK: - Content

struct RecorderContent: HandyJSON {
    let name = ""
    let image = ""
    let kaluli = ""
}

// MARK: - WaterAttract

struct WaterAttract: HandyJSON {
    let target = 0
    let attracted = 0
}

// MARK: - food

struct TimeAndFood {
    var time: String = ""
    var food: String = ""
}
