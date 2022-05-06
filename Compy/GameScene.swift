//
//  GameScene.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    let cam = SKCameraNode()
    let motionManager = CMMotionManager()
    let ground = Ground()
    let compy = Compy()
    let alien1 = Alien(position: CGPoint(x: 300, y: 250))
    let alien2 = Alien(position: CGPoint(x: 50, y: 250))
    
    //function to implement any custom behavior for your scene
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        self.anchorPoint = .zero
        self.camera = cam
        self.motionManager.startAccelerometerUpdates()
    
        compy.position = CGPoint(x: 150, y: 250)
                
        //positioning ground
        ground.position = CGPoint(x: -self.size.width*2, y: 30)
        ground.size = CGSize(width: self.size.width*6, height: 0)
        ground.tileGround()
        self.addChild(ground)
        self.addChild(compy)
        self.addChild(alien1)
        self.addChild(alien2)
    }
    
    // function that is called by the system exactly once per frame
    override func didSimulatePhysics() {
        self.camera!.position = compy.position
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
            }
        }
        
    }
    
    
    //Tells your app to perform any app-specific logic to update your scene
    override func update(_ currentTime: TimeInterval) {
        compy.update()
        
        if let accelData = self.motionManager.accelerometerData {
            var forceAmount: CGFloat
            var movement = CGVector()
            
            switch UIDevice.current.orientation {
            case .landscapeLeft:

                forceAmount = 13000
            
            case .landscapeRight:
                forceAmount = -13000
            
            default:
                forceAmount = 0
                
            }
            
            if (accelData.acceleration.y > 0.15) {
                movement.dx = -forceAmount
                
            } else if (accelData.acceleration.y < -0.15) {
                
                movement.dx = forceAmount
            }
            
            compy.physicsBody?.applyForce(movement)
        }
    }
}
