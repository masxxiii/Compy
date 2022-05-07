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
    
    var screenCenter = CGFloat()
    
    var initialCompyPosition = CGPoint(x: 50, y: 300)
    
    var compyProgress = CGFloat()
    
    // function to implement any custom behavior for your scene
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        self.anchorPoint = .zero
        self.camera = cam
        self.motionManager.startAccelerometerUpdates()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        screenCenter = self.size.height / 2
                
        // adding ground to the scene
        ground.position = CGPoint(x: -self.size.width * 2, y: 80)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.tileGround()
        self.addChild(ground)
        
        // adding Compy to the scene
        compy.position = initialCompyPosition
        self.addChild(compy)
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
