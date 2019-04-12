//
//  Player.swift
//  TechDra
//
//  Created by Master on 2015/03/24.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var name: String!
    var maxHP: Float!
    var currentHP: Float!
    var attackPoint: Float!
    var defencePoint: Float!
    var speed: Float!
    var image: UIImage!
    var level: Int!
    
    override init() {
        super.init()
        
        name = "勇者"
        maxHP = 1000
        currentHP = 1000
        attackPoint = 60
        defencePoint = 2
        speed = 1.2
        image = UIImage(named: "yusha")
        level = 1
    }
}
