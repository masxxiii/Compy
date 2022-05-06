//
//  Compy.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class Compy: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Compy")
    var initialSize: CGSize = CGSize(width: 100, height: 100)
    
    // function for adding tap functionality.
    func onTap() {}
}
