//
//  ViewController.swift
//  MFi Controller
//
//  Created by Richthofen on 28/03/2017.
//  Copyright © 2017 VanLiuJianqiao. All rights reserved.
//

import UIKit
import GameController

class ViewController: UIViewController {
    var mainController: GCController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.controllerWasConnected),
                                               name: NSNotification.Name.GCControllerDidConnect,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.controllerWasDisconnected),
                                               name: NSNotification.Name.GCControllerDidDisconnect,
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func reactToInput() {
        guard let profile: GCExtendedGamepad = self.mainController?.extendedGamepad else {
            return
        }
        
        profile.valueChangedHandler = ({
            (gamepad: GCExtendedGamepad, element: GCControllerElement) in
            
            var position = CGPoint(x: 0, y: 0)
            var message: String = ""
            
            // left trigger
            if (gamepad.leftTrigger == element && gamepad.leftTrigger.isPressed) {
                message = "Left Trigger"
            }
            
            // right trigger
            if (gamepad.rightTrigger == element && gamepad.rightTrigger.isPressed) {
                message = "Right Trigger"
            }
            
            // left shoulder button
            if (gamepad.leftShoulder == element && gamepad.leftShoulder.isPressed) {
                message = "Left Shoulder Button"
            }
            
            // right shoulder button
            if (gamepad.rightShoulder == element && gamepad.rightShoulder.isPressed) {
                message = "Right Shoulder Button"
            }
            
            // A button
            if (gamepad.buttonA == element && gamepad.buttonA.isPressed) {
                message = "A Button"
            }
            
            // B button
            if (gamepad.buttonB == element && gamepad.buttonB.isPressed) {
                message = "B Button"
            }
            
            // X button
            if (gamepad.buttonX == element && gamepad.buttonX.isPressed) {
                message = "X Button"
            }
            
            // Y button
            if (gamepad.buttonY == element && gamepad.buttonY.isPressed) {
                message = "Y Button"
            }
            
            // d-pad
            if (gamepad.dpad == element) {
                if (gamepad.dpad.up.isPressed) {
                    message = "D-Pad Up"
                }
                if (gamepad.dpad.down.isPressed) {
                    message = "D-Pad Down"
                }
                if (gamepad.dpad.left.isPressed) {
                    message = "D-Pad Left"
                }
                if (gamepad.dpad.right.isPressed) {
                    message = "D-Pad Right"
                }
            }
            
            // left stick
            if (gamepad.leftThumbstick == element) {
                if (gamepad.leftThumbstick.up.isPressed) {
                    message = "Left Stick %f \(gamepad.leftThumbstick.yAxis.value)"
                }
                if (gamepad.leftThumbstick.down.isPressed) {
                    message = "Left Stick %f \(gamepad.leftThumbstick.yAxis.value)"
                }
                if (gamepad.leftThumbstick.left.isPressed) {
                    message = "Left Stick %f \(gamepad.leftThumbstick.xAxis.value)"
                }
                if (gamepad.leftThumbstick.right.isPressed) {
                    message = "Left Stick %f \(gamepad.leftThumbstick.xAxis.value)"
                }
//                position = CGPoint(x: gamepad.leftThumbstick.xAxis.value, y: gamepad.leftThumbstick.yAxis.value)
                position = CGPoint(x: CGFloat(gamepad.leftThumbstick.xAxis.value),
                                   y: CGFloat(gamepad.leftThumbstick.yAxis.value))
            }
            
            // right stick
            if (gamepad.rightThumbstick == element) {
                if (gamepad.rightThumbstick.up.isPressed) {
                    message = "Right Stick %f \(gamepad.rightThumbstick.yAxis.value)"
                }
                if (gamepad.rightThumbstick.down.isPressed) {
                    message = "Right Stick %f \(gamepad.rightThumbstick.yAxis.value)"
                }
                if (gamepad.rightThumbstick.left.isPressed) {
                    message = "Right Stick %f \(gamepad.rightThumbstick.xAxis.value)"
                }
                if (gamepad.rightThumbstick.right.isPressed) {
                    message = "Right Stick %f \(gamepad.rightThumbstick.xAxis.value)"
                }
//                position = CGPoint(x: gamepad.rightThumbstick.xAxis.value, y: gamepad.rightThumbstick.yAxis.value)
                position = CGPoint(x: CGFloat(gamepad.rightThumbstick.xAxis.value),
                                   y: CGFloat(gamepad.rightThumbstick.yAxis.value))
            }
            
            print(message)
        }) as GCExtendedGamepadValueChangedHandler
    }
    
    @objc private func controllerWasConnected(_ notification: Notification) {
        let controller: GCController = notification.object as! GCController
        let status = "MFi Controller: \(controller.vendorName) is connected"
        print(status)
        
        mainController = controller
        reactToInput()
    }
    
    @objc private func controllerWasDisconnected(_ notification: Notification) {
        let controller: GCController = notification.object as! GCController
        let status = "MFi Controller: \(controller.vendorName) is disconnected"
        print(status)
        
        mainController = nil
    }
}

