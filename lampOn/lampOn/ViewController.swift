//
//  ViewController.swift
//  lampOn
//
//  Created by Eric Rojas Pech on 30/09/23.
//


import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var buttonSwitch: UIButton!
    
    @IBOutlet weak var imageLamp: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        //use the functions to chanche the background when it pressed
        if view.backgroundColor == .black{
            changeColorToWhite()
            turnOnFlash()
            vibrateHaptic(style: .success)

        }else{
            changeColorToBlack()
            turnOffFlash()
            vibrateHaptic(style: .error)

        }
        
        //Change te color to white
        func changeColorToWhite(){
            view.backgroundColor = .white
            buttonSwitch.setTitle("Turn Off", for: .normal)
            buttonSwitch.setTitleColor(.black, for: .normal)
            imageLamp.image = UIImage(named: "lampOn2")
        }
        
        //Change the color to black
        func changeColorToBlack(){
            view.backgroundColor = .black
            buttonSwitch.setTitle("Turn On", for: .normal)
            buttonSwitch.setTitleColor(.white, for: .normal)
            imageLamp.image = UIImage(named: "lampOff2")
        }
        
        func turnOnFlash() {
            toggleFlash(on: true)
        }

        // Function to turn off the flash
        func turnOffFlash() {
            toggleFlash(on: false)
        }

        // Function to toggle the flash
        func toggleFlash(on: Bool) {
            guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }

            if device.hasTorch {
                do {
                    try device.lockForConfiguration()

                    if on {
                        try device.setTorchModeOn(level: 1.0)
                    } else {
                        device.torchMode = AVCaptureDevice.TorchMode.off
                    }

                    device.unlockForConfiguration()
                } catch {
                    print("Error toggling flash: \(error)")
                }
            }
        }
        
        func vibrateHaptic(style: UINotificationFeedbackGenerator.FeedbackType) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(style)
        }
        
    }
}

