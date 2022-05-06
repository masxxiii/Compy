//
//  Battery.swift
//  Compy
//
//  Created by Masood Zafar on 07.05.2022.
//

import SpriteKit

class Battery: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"Environment")
    
    var initialSize: CGSize = CGSize(width: 40, height: 50)
    
    var pulseAnimation = SKAction()
    
    var value = 10
    
    // initialization instance.
    init() {
        let batteryTexture = textureAtlas.textureNamed("battery")
        super.init(texture: batteryTexture, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        addAnimations()
        self.run(pulseAnimation)
    }
    
    // function for adding animations.
    func addAnimations()
    {
        let pulseOutGroup = SKAction.group([
            SKAction.fadeAlpha(to: 0.85, duration: 0.8),
            SKAction.scale(to: 0.6, duration: 0.8),
            SKAction.rotate(byAngle: -0.3, duration: 0.8)
        ])
        
        let pulseInGroup = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1.5),
            SKAction.scale(to: 1, duration: 1.5),
            SKAction.rotate(byAngle: 3.5, duration: 1.5)
        ])
        
        let pulseSequence = SKAction.sequence([
            pulseOutGroup,
            pulseInGroup
        ])
        
        pulseAnimation = SKAction.repeatForever(pulseSequence)
    }
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
