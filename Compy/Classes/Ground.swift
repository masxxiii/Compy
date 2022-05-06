//
//  Ground.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class Ground: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"Environment")
    
    var initialSize: CGSize = CGSize.zero
    
    var jumpWidth = CGFloat()
    
    var jumpCount = CGFloat(1)
    
    // function for tiling ground texture across the width of tile node.
    func tileGround()
    {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        let texture = textureAtlas.textureNamed("ground")
        let tileSize = CGSize(width: 35, height: 300)
        var tileCount: CGFloat = 0
        
        while (tileCount * tileSize.width < self.size.width)
        {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)

            self.addChild(tileNode)
            tileCount += 1
        }
        
        jumpWidth = tileSize.width * floor(tileCount / 3)
        solidifyGround()
    }
    
    // function for checking reposition.
    func checkForReposition(playerProgress: CGFloat)
    {
        let groundJumpPosition = jumpWidth * jumpCount
        
        if (playerProgress >= groundJumpPosition)
        {
            self.position.x += jumpWidth
            jumpCount += 1
        }
    }
    
    // function for adding physics to our ground.
    func solidifyGround() {
        let pointTopLeft = CGPoint(x: 0, y: 0)
        let pointTopRight = CGPoint(x: size.width, y: 0) 
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
    }
    
    // function for adding tap functionality.
    func onTap() {}
}
