//
//  EncounterManager.swift
//  Compy
//
//  Created by Masood Zafar on 08.05.2022.
//

import SpriteKit

class EncounterManager {
    
    let encounterNames: [String] = [
        "EncounterA"
    ]
    
    var encounters: [SKNode] = []
    
    init() {
        
        // Loop through our Encounters
        for encounterFileName in encounterNames {
            
            let encounterNode = SKNode()
            
            // Load this scene file into a SKScene instance:
            if let encounterScene = SKScene(fileNamed: encounterFileName) {
                // Loop through each child node in the SKScene
                for child in encounterScene.children {
                    // Create a copy of the scene's child node
                    // to add to our encounter node:
                    let copyOfNode = type(of: child).init()
                    // Save the scene node's position to the copy:
                    copyOfNode.position = child.position
                    // Save the scene node's name to the copy:
                    copyOfNode.name = child.name
                    // Add the copy to our encounter node:
                    encounterNode.addChild(copyOfNode)
                }
            }
            
            // Add the populated encounter node to the array:
            encounters.append(encounterNode)
        }
    }
    
    // We will call this addEncountersToScene function from
    // the GameScene to append all of the encounter nodes to the
    // world node from our GameScene:
    func addEncountersToScene(gameScene: SKNode) {
        var encounterPosY = 1000
        for encounterNode in encounters {
            // Spawn the encounters behind the action, with
            // increasing height so they do not collide:
            encounterNode.position = CGPoint(x: -2000,
                                             y: encounterPosY)
            gameScene.addChild(encounterNode)
            // Double the Y pos for the next encounter:
            encounterPosY *= 2
        }
    }
}
