//
//  Droid.swift
//  Compy
//
//  Created by Masood Zafar on 08.05.2022.
//

import SpriteKit

class Droid: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"Droid")
    
    var initialSize: CGSize = CGSize(width: 48, height: 28)
    
    var animation = SKAction()
    
    // initialization instance.
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        addAnimations()
        addPhysics()
        self.run(animation)
    }
    
    // function for adding animations to our sprite.
    func addAnimations() {
        let animatedFrames: [SKTexture] = [
            textureAtlas.textureNamed("droid1"),
            textureAtlas.textureNamed("droid2"),
            textureAtlas.textureNamed("droid3")
        ]
        
        let animatedAction = SKAction.animate(with: animatedFrames, timePerFrame: 0.20)
        animation = SKAction.repeatForever(animatedAction)
    }
    
    // function for adding physics to our sprite.
    func addPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
    }
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
