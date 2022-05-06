//
//  GameSprite.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get set }
    
    var initialSize: CGSize { get set }
    
    func onTap()
}
