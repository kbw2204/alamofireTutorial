//
//  Book.swift
//  alamofireTest
//
//  Created by 융융 on 2021/01/10.
//

import Foundation

struct Books: Codable {
    var books: [Book]
    var total: String
    var page: String
}

struct Book: Codable {
    var isbn13: String
    var subtitle: String
    var url: String
    var thumbnail: String
    var title: String
    var price: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case isbn13
        case price
        case thumbnail = "image" // 요런식으로 따로 적용해줄 수도 있습니당. 근데 요렇게는 안쓰죠 ㅋㅋ;;
        case url
    }
}
