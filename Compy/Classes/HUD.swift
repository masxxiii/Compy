//
//  HUD.swift
//  Compy
//
//  Created by Masood Zafar on 09.05.2022.
//

import SpriteKit

class HUD: SKNode {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "HUD")
    
    var batteryAtlas: SKTextureAtlas = SKTextureAtlas(named: "Environment")
    
    var healthNodes: [SKSpriteNode] = []
    
    var totalScore: SKLabelNode = SKLabelNode(text: "000000")
    
    // function for creating HUD nodes
    func creatHudNodes(screenSize: CGSize) {
        let cameraOrigin = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        
        let batteryIcon = SKSpriteNode(texture: batteryAtlas.textureNamed("battery"))
        batteryIcon.position = CGPoint(x: -cameraOrigin.x + 23, y: cameraOrigin.y - 23)
        batteryIcon.size = CGSize(width: 17, height: 27)
        
        totalScore.fontName = "AvenirNext-HeavyItalic"
        totalScore.position = CGPoint(x: -cameraOrigin.x + 41, y: cameraOrigin.y - 23)
        
        totalScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        totalScore.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        self.addChild(batteryIcon)
        self.addChild(totalScore)
        
        for index in 0 ..< 3 {
            let newHealthNode = SKSpriteNode(texture: textureAtlas.textureNamed("heart"))
            newHealthNode.size = CGSize (width: 46, height: 40)
            // Position the hearts below the coins:
            let xPos = -cameraOrigin.x + CGFloat(index * 58) + 33
            let yPos = cameraOrigin.y - 66
            newHealthNode.position = CGPoint(x: xPos, y: yPos)
            // Keep track of nodes in an array property:
            healthNodes.append(newHealthNode)
            // Add the heart nodes to the HUD:
            self.addChild(newHealthNode)
        }
    }
    
    //function for updating totalScore
    func updateScore(newBatteryCount: Int) {
        // We can use the NSNumberFormatter class to pad
        // leading 0's onto the coin count:
        let formatter = NumberFormatter()
        let number = NSNumber(value: newBatteryCount)
        formatter.minimumIntegerDigits = 6
        if let scoreString = formatter.string(from: number) {
            // Update the label node with the new count:
            totalScore.text = scoreString
        }
    }
    
    
    // function for updating heart graphic
    func setHealthDisplay(newHealth: Int) {
        // Create a fade SKAction to fade lost hearts:
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0.3)
        // Loop through each health node and update its status:
        for index in 0 ..< healthNodes.count {
            if index < newHealth {
                // This heart should be full red:
                healthNodes[index].alpha = 1
            } else {
                // This heart should be faded:
                healthNodes[index].run(fadeAction)
            }
        }
    }
}
