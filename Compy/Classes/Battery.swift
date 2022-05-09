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
    
    var value = 100
    
    // initialization instance.
    init() {
        let batteryTexture = textureAtlas.textureNamed("battery")
        super.init(texture: batteryTexture, color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Battery.rawValue
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
    
    // function for collecting battery
    func collect() {
        self.physicsBody?.categoryBitMask = 0
        
        let collectAnimation = SKAction.group([
            SKAction.fadeAlpha(to: 0, duration: 0.2),
            SKAction.scale(to: 1.5, duration: 0.2),
            SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)
        ])
        
        let resetAfterCollected = SKAction.run {
            self.position.y = 5000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.Battery.rawValue
        }
        // Combine the actions into a sequence:
        let collectSequence = SKAction.sequence([
            collectAnimation,
            resetAfterCollected
        ])
        // Run the collect animation:
        self.run(collectSequence)
    }
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
