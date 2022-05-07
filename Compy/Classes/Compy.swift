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
    
    var jumpAnimation = SKAction()
    
    var standAnimation = SKAction()
    
    var deadAnimation = SKAction()
    
    var moveRightAnimation = SKAction()
    
    var moveLeftAnimation = SKAction()
    
    var jumping = false
    
    var movingLeft = false
    
    var movingRight = false
    
    let maxHeight: CGFloat = 270
    
    let maxJumpingForce: CGFloat = 170000
    
    // initialization instance.
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        addJumpAnimations()
        addStandAnimations()
        addDeadAnimations()
        addMoveRightAnimations()
        addMoveLeftAnimations()
        addPhysics()
        self.run(standAnimation, withKey: "standAnimation")
    }
    
    // function for adding jump animation.
    func addJumpAnimations()
    {
        let jumpFrames: [SKTexture] = [textureAtlas.textureNamed("jump")]
        let jumpAction = SKAction.animate(with: jumpFrames, timePerFrame: 0.03)
        jumpAnimation = SKAction.repeatForever(jumpAction)
    }
    
    // function for adding stand animation.
    func addStandAnimations() {
        let standFrames: [SKTexture] = [textureAtlas.textureNamed("stand")]
        let standAction = SKAction.animate(with: standFrames, timePerFrame: 0.03)
        standAnimation = SKAction.repeatForever(standAction)
    }
    
    // function for adding dead animation.
    func addDeadAnimations() {
        let deadFrames: [SKTexture] = [textureAtlas.textureNamed("dead")]
        let deadAction = SKAction.animate(with: deadFrames, timePerFrame: 0.03)
        deadAnimation = SKAction.repeatForever(deadAction)
    }
    
    // function for adding right movement animation.
    func addMoveRightAnimations() {
        let moveRightFrames: [SKTexture] = [
            textureAtlas.textureNamed("move1"),
            textureAtlas.textureNamed("move2"),
            textureAtlas.textureNamed("move3"),
            textureAtlas.textureNamed("move4"),
            textureAtlas.textureNamed("move5"),
            textureAtlas.textureNamed("move6")
        ]
        let moveRightAction = SKAction.animate(with: moveRightFrames, timePerFrame: 0.03)
        moveRightAnimation = SKAction.repeatForever(moveRightAction)
    }
    
    // function for adding left movement animation.
    func addMoveLeftAnimations() {
        let moveLeftFrames: [SKTexture] = [
            textureAtlas.textureNamed("move6"),
            textureAtlas.textureNamed("move5"),
            textureAtlas.textureNamed("move4"),
            textureAtlas.textureNamed("move3"),
            textureAtlas.textureNamed("move2"),
            textureAtlas.textureNamed("move1")
        ]
        let moveLeftAction = SKAction.animate(with: moveLeftFrames, timePerFrame: 0.03)
        moveLeftAnimation = SKAction.repeatForever(moveLeftAction)
    }
    
    // function for adding physics to our sprite.
    func addPhysics() {
        let bodyTexture = textureAtlas.textureNamed("stand")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 30
        self.physicsBody?.allowsRotation = false
    }
    
    // function for making our sprite start jumping.
    func startJumping() {
        self.removeAction(forKey: "standAnimation")
        self.run(jumpAnimation, withKey: "jumpAnimation")
        self.jumping = true
    }
    
    // function for making our sprite stop jumping.
    func stopJumping() {
        self.removeAction(forKey: "jumpAnimation")
        self.run(standAnimation, withKey: "standAnimation")
        self.jumping = false
    }
    
    // function for making our sprite move left.
    func moveLeft() {
        self.removeAction(forKey: "moveRightAnimation")
        self.run(moveLeftAnimation, withKey: "moveLeftAnimation")
        self.movingLeft = true
        self.movingRight = false
    }
    
    // function for making our sprite move right.
    func moveRight() {
        self.removeAction(forKey: "moveLeftAnimation")
        self.run(moveRightAnimation, withKey: "moveRightAnimation")
        self.movingRight = true
        self.movingLeft = false
    }
    
    // function for updating our sprite.
    func update() {
        // applying jump
        if (self.jumping) {
            var forceToApply = maxJumpingForce
            
            if (position.y > 100) {
                let percentageOfMaxHeight = (position.y / maxHeight)
                let JumpingForceSubtraction = percentageOfMaxHeight * maxJumpingForce
                
                forceToApply -= JumpingForceSubtraction
            }
            
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
            
            if (self.physicsBody!.velocity.dy > 400) {
                self.physicsBody!.velocity.dy = 300
            }
        }
        
        // moving left
        if ((self.physicsBody?.velocity.dx)! < 0 && !self.movingLeft) {
            self.moveLeft()
        }
        
        // moving right
        if ((self.physicsBody?.velocity.dx)! > 0 && !self.movingRight) {
            self.moveRight()
        }
        
    }
    
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
