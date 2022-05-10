//
//  MenuScene.swift
//  Compy
//
//  Created by Masood Zafar on 10.05.2022.
//

import SpriteKit

class MenuScene: SKScene {
    
    //Grab the HUD sprite atlas:
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"HUD")
    
    //Instantiate a sprite node for the start button
    let startButton = SKSpriteNode()
    
    // function to implement any custom behavior for your scene
    override func didMove(to view: SKView){
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        
        // title of the game
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text = "Compy"
        logoText.fontColor = UIColor(red: 0.00, green: 0.38, blue: 0.66, alpha: 1.00)
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)
        
        // start game button
        startButton.texture = textureAtlas.textureNamed("start")
        startButton.size = CGSize(width: 50, height: 50)
        startButton.name = "StartButton"
        startButton.position = CGPoint(x: 0, y: -30)
        self.addChild(startButton)
        
        // start text
        let startText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        startText.text = "Click Play To Start The Game."
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: -100)
        startText.fontSize = 30
        startText.name = "StartText"
        startText.zPosition = 5
        self.addChild(startText)
        
        // pulse the start text in and out gently:
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9),
        ])
        
        startText.run(SKAction.repeatForever(pulseAction))
    }
    
    //UIKit calls this function when a new touch is detected in a view or window
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
        }
    }
}
