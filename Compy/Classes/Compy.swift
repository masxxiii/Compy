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
    
    var damagedAnimation = SKAction()
    
    var moveRightAnimation = SKAction()
    
    var moveLeftAnimation = SKAction()
    
    var jumping = false
    
    var movingLeft = false
    
    var movingRight = false
    
    var damaged = false
    
    var isDead = false
    
    var health: Int = 3
    
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
        self.physicsBody?.categoryBitMask = PhysicsCategory.Compy.rawValue
        self.physicsBody?.contactTestBitMask =
            PhysicsCategory.Alien.rawValue |
            PhysicsCategory.Droid.rawValue |
            PhysicsCategory.Powerup.rawValue |
            PhysicsCategory.Ground.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ground.rawValue
    }
    
    // function for making our sprite start jumping.
    func startJumping() {
        self.removeAction(forKey: "standAnimation")
        self.run(jumpAnimation, withKey: "jumpAnimation")
        self.jumping = true
        if self.health <= 0 { return }
    }
    
    // function for making our sprite stop jumping.
    func stopJumping() {
        self.removeAction(forKey: "jumpAnimation")
        self.jumping = false
    }
    
    // function for making our sprite move left.
    func moveLeft() {
        self.removeAction(forKey: "moveRightAnimation")
        self.run(moveLeftAnimation, withKey: "moveLeftAnimation")
        self.movingLeft = true
        self.movingRight = false
        if self.health <= 0 { return }
    }
    
    // function for making our sprite move right.
    func moveRight() {
        self.removeAction(forKey: "moveLeftAnimation")
        self.run(moveRightAnimation, withKey: "moveRightAnimation")
        self.movingRight = true
        self.movingLeft = false
        if self.health <= 0 { return }
    }
    
    // function for making our sprite stand still.
    func standStill() {
        self.removeAction(forKey: "jumpAnimation")
        self.removeAction(forKey: "moveLeftAnimation")
        self.removeAction(forKey: "moveRightAnimation")
        self.run(standAnimation, withKey: "standAnimation")
        self.movingLeft = false
        self.movingRight = false
        if self.health <= 0 { return }
    }
    
    // function for making our sprite dead.
    func dead() {
        self.alpha = 1
        self.removeAllActions()
        self.run(self.deadAnimation)
    }
    
    // function for taking damage.
    func takeDamage() {
        if self.damaged { return }
        self.health -= 1
        if self.health == 0 {
            dead()
            self.isDead = true
        } else {
            self.run(self.damagedAnimation)
        }
    }
    
    // function for updating our sprite.
    func update() {
        
        // is dead
        if (self.isDead) {
            return
        }
        
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
        
        // standing still
        if ((self.physicsBody?.velocity.dx)!.isZero && !self.jumping) {
            self.standStill()
        }
        
    }
    
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
