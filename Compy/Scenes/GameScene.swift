//
//  GameScene.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let cam = SKCameraNode()
    
    let motionManager = CMMotionManager()
    
    let encounterManager = EncounterManager()
    
    let ground = Ground()
    
    let compy = Compy()
    
    let powerUpBattery = Battery()
    
    var screenCenter = CGFloat()
    
    var initialCompyPosition = CGPoint(x: 50, y: 300)
    
    var compyProgress = CGFloat()
    
    var nextEncounterSpawnPosition = CGFloat(150)
    
    // function to implement any custom behavior for your scene
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        self.anchorPoint = .zero
        self.camera = cam
        self.motionManager.startAccelerometerUpdates()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -15)
        screenCenter = self.size.height / 2
                
        // adding ground to the scene
        ground.position = CGPoint(x: -self.size.width * 2, y: 80)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.tileGround()
        self.addChild(ground)
        
        // adding Compy to the scene
        compy.position = initialCompyPosition
        self.addChild(compy)
        
        // adding battery to the scene
        powerUpBattery.position = CGPoint(x: -2000, y: -2000)
        self.addChild(powerUpBattery)
        
        // adding encounters
        encounterManager.addEncountersToScene(gameScene: self)
        encounterManager.encounters[0].position = CGPoint(x: 400, y: 330)
        
        // adding physics world
        self.physicsWorld.contactDelegate = self
    }
    
    // method that is fired when contact occurs
    func didBegin(_ contact: SKPhysicsContact) {
        // Each contact has two bodies,
        // We do not know which is which.
        // We will find the compy body first, then use
        // the other body to determine the type of contact.
        let otherBody: SKPhysicsBody
        // Combine the two compy physics categories into one
        // bitmask using the bitwise OR operator |
        let compyMask = PhysicsCategory.Compy.rawValue |
            PhysicsCategory.DamagedCompy.rawValue
        // Use the bitwise AND operator & to find the compy.
        // This returns a positive number if body A's category
        // is the same as either the penguin or damagedCompy:
        if (contact.bodyA.categoryBitMask & compyMask) > 0 {
            // bodyA is the compy, we will test bodyB's type:
            otherBody = contact.bodyB
        }
        else {
            // bodyB is the compy, we will test bodyA's type:
            otherBody = contact.bodyA
        }
        
        // Find the type of contact:
        switch otherBody.categoryBitMask {
        
        case PhysicsCategory.Ground.rawValue:
            print("hit the ground")
        case PhysicsCategory.Alien.rawValue:
            print("take damage")
            compy.takeDamage()
        case PhysicsCategory.Droid.rawValue:
            print("take damage")
            compy.takeDamage()
        case PhysicsCategory.Powerup.rawValue:
            print("power-up")
        default:
            print("Contact with no game logic")
        }
    }
    
    // method that is called by the system exactly once per frame
    override func didSimulatePhysics() {
            
        var cameraYPos = screenCenter
        cam.yScale = 1
        cam.xScale = 1
        
        if (compy.position.y > screenCenter) {
            cameraYPos = compy.position.y
            let percentageOfMaxHeight = (compy.position.y - screenCenter) / (compy.maxHeight - screenCenter)
            let newScale = 1 + percentageOfMaxHeight
            cam.xScale = newScale
            cam.yScale = newScale
        }
        
        self.camera!.position = CGPoint(x: compy.position.x, y: cameraYPos)
        compyProgress = compy.position.x - initialCompyPosition.x
        ground.checkForReposition(compyProgress: compyProgress)
        
        // Check to see if we should set a new encounter:
        if compy.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1200
            // Each encounter has a 10% chance to spawn a star:
            let batteryRandom = Int(arc4random_uniform(10))
            if batteryRandom == 0 {
                // Only move the star if it is off the screen.
                if abs(compy.position.x - powerUpBattery.position.x) > 1200 {
                    powerUpBattery.position = CGPoint(x: nextEncounterSpawnPosition, y: 100.0)
                    // Remove any previous velocity and spin:
                    powerUpBattery.physicsBody?.angularVelocity = 0
                    powerUpBattery.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                }
            }
        }
    }
    
    //UIKit calls this function when a new touch is detected in a view or window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches)
        {
            let location = touch.location(in: self)
            
            let nodeTouched = atPoint(location)
            
            if let gameSprite = nodeTouched as? GameSprite
            {
                gameSprite.onTap()
                compy.startJumping()
            }
        }
        
    }
    
    //UIKit calls this method when a finger or Apple Pencil is no longer touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        compy.stopJumping()
    }
    
    //UIKit calls this method when it receives a system interruption requiring cancellation of the touch sequence
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        compy.stopJumping()
    }
    
    
    //Tells your app to perform any app-specific logic to update your scene
    override func update(_ currentTime: TimeInterval) {
        compy.update()
        
        if let accelData = self.motionManager.accelerometerData {
            var forceAmount: CGFloat
            var movement = CGVector()
            
            switch UIDevice.current.orientation {
            case .landscapeLeft:
                forceAmount = 19000
            
            case .landscapeRight:
                forceAmount = -19000
            
            default:
                forceAmount = 0
                
            }
            
            if (accelData.acceleration.y > 0.15 && !compy.isDead) {
                movement.dx = -forceAmount
            }
            else if (accelData.acceleration.y < -0.15 && !compy.isDead) {
                movement.dx = forceAmount
            }
            
            compy.physicsBody?.applyForce(movement)
        }
    }
}
