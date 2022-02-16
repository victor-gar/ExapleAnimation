//
//  Food.swift
//  AdvancedAnimation
//
//  Created by Victor Garitskyu on 17.01.2022.
//

import SwiftUI

struct Food: Identifiable{
    var id = UUID().uuidString
    var itemImage: String
    var itemTitle: String
    
}

var foods = [
Food(itemImage: "food1", itemTitle: "cake1"),
Food(itemImage: "food2", itemTitle: "cake2"),
Food(itemImage: "food3", itemTitle: "cake3"),

]
