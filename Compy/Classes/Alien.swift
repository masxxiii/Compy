//
//  Alien.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class Alien: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"Alien")
    
    var initialSize: CGSize = CGSize(width: 40, height: 40)
    
    var animation = SKAction()
    
    // initialization instance.
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        addAnimations()
        addPhysics()
        self.run(animation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Alien.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.DamagedCompy.rawValue
    }
    
    // function for adding animations to our sprite.
    func addAnimations() {
        let animatedFrames: [SKTexture] = [
            textureAtlas.textureNamed("alien_reaction1"),
            textureAtlas.textureNamed("alien_reaction2")
        ]
        
        let animatedAction = SKAction.animate(with: animatedFrames, timePerFrame: 0.20)
        animation = SKAction.repeatForever(animatedAction)
    }
    
    // function for adding physics to our sprite.
    func addPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
    }
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
