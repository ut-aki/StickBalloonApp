//
//  ViewController.swift
//  StickBalloonApp
//
//  Created by 藤田晃弘 on 2017/05/13.
//  Copyright © 2017年 T6SDL. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion
import NCMB

class ViewController: UIViewController {
    
//  AppDegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//  Outlet
    @IBOutlet var mainVC: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var sideChangeButton: UIButton!
    @IBOutlet weak var soundChangeButton: UIButton!
    @IBOutlet weak var creditsView: UIView!
    
//  NCMB
    let object = NCMBObject(className: "Supporters", objectId: "ZCtQnIb3c1GrUlj6")
    
//  variable to hide View of Setting
    var flag: Bool!
    
//  Accelerometer
    var myMotionManager: CMMotionManager!
    
    var acceleX: Double = 0
    var acceleY: Double = 0
    var acceleZ: Double = 0
    let Alpha = 0.4
    
    var xPast: Double = 0
    var yPast: Double = 0
    var zPast: Double = 0
    
    var subX: Double = 0
    var subY: Double = 0
    var subZ: Double = 0
    
//  Sound FX
    var audioPlayerClear: AVAudioPlayer! = nil
    
//  View index
    var index: Int = 0
    
//  standard func
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeSound()
        
        if appDelegate.sideNum.integer(forKey: "sideNum") == 0 {
            wasedaBack()
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 1 {
            keioBack()
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 2 {
            audienceBack()
        }
        
        flag = false
        
        settingView.layer.borderColor = UIColor.red.cgColor
        settingView.layer.borderWidth = 3
        settingView.isHidden = true
        
        creditsView.isHidden = true
        
        sideChangeButtonTitleLabel()
        soundChangeButtonTitleLabel()
        
        myMotionManager = CMMotionManager()
        myMotionManager.accelerometerUpdateInterval = 0.1
        myMotionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                self.highpassFilter(acceleration: accelData!.acceleration)
        })
        
    }
    
//  BackgroundColor at WASEDA
    func wasedaBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.6932106599, green: 0.1560991657, blue: 0.08986309497, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = mainVC.bounds
        mainVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  BackgroundColor at KEIO
    func keioBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.006702585355, green: 0.195407935, blue: 1, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = mainVC.bounds
        mainVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  BackgroundColor at AUDIENCE
    func audienceBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.8464665292, green: 0.7834377073, blue: 0.08577214193, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = mainVC.bounds
        mainVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  func for playSound using Accelerometer
    func highpassFilter(acceleration: CMAcceleration) {
        acceleX = Alpha * acceleration.x + acceleX * (1.0 - Alpha)
        acceleY = Alpha * acceleration.y + acceleY * (1.0 - Alpha)
        acceleZ = Alpha * acceleration.z + acceleZ * (1.0 - Alpha)
        
        let xh = acceleration.x - acceleX
        let yh = acceleration.y - acceleY
        let zh = acceleration.z - acceleZ
        
        subX = (xh - xPast) * (xh - xPast)
        subY = (yh - yPast) * (yh - yPast)
        subZ = (zh - zPast) * (zh - zPast)
        
        xPast = xh
        yPast = yh
        zPast = zh
        
        playSound()
    }
    
//  func for stopping Accelerometer
    func stopAccelerometer() {
        if(myMotionManager.isAccelerometerActive) {
            myMotionManager.stopAccelerometerUpdates()
        }
    }
    
//  func for import sound file
    func makeSound() {
        let soundFilePathClear: NSString = Bundle.main.path(forResource: appDelegate.soundFXs[appDelegate.soundNum], ofType: "wav")! as NSString
        let soundClear: NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        
        do {
            audioPlayerClear = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint: nil)
        } catch {
            
        }
        audioPlayerClear.volume = 2.0
        audioPlayerClear.prepareToPlay()
    }
    
//  func for play the sound
    func playSound() {
        if subX + subY + subZ > 1.2 {
            self.audioPlayerClear.play()
        }
    }
    
//  func onClick people
    @IBAction func onClickSupporter(_ sender: UIButton) {
        stopAccelerometer()
        index = 0
    }
    
    
//  func onClick setting
    @IBAction func onClickSetting(_ sender: UIButton) {
        if !flag {
            settingView.isHidden = false
            flag = true
            stopAccelerometer()
        } else {
            settingView.isHidden = true
            flag = false
            myMotionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                self.highpassFilter(acceleration: accelData!.acceleration)
            })

        }
    }
    
//  func onClick credits
    @IBAction func onClickCredits(_ sender: UIButton) {
        creditsView.isHidden = false
        settingView.isHidden = true
    }
    
//  func onClick close
    @IBAction func onClickClose(_ sender: UIButton) {
        creditsView.isHidden = true
        settingView.isHidden = false
    }
    
    
//  TitleLabel of sideChangeButton
    func sideChangeButtonTitleLabel() {
        sideChangeButton.titleLabel?.font = UIFont(name: "Bebas Neue", size: 36)
        sideChangeButton.tintColor = UIColor.white
        sideChangeButton.setTitle(appDelegate.userSide[appDelegate.sideNum.integer(forKey: "sideNum")], for: .normal)
    }
    
//  TitleLabel of soundChangeButton
    func soundChangeButtonTitleLabel() {
        soundChangeButton.titleLabel?.font = UIFont(name: "Bebas Neue", size: 36)
        soundChangeButton.tintColor = UIColor.white
        soundChangeButton.setTitle(appDelegate.soundType[appDelegate.soundNum], for: .normal)
    }
    
//  sideChange on SettingView
    @IBAction func onClickToChangeSide(_ sender: Any) {
        if appDelegate.sideNum.integer(forKey: "sideNum") == 0 {
            appDelegate.sideNum.set(1, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            keioBack()
            decreaseSup(of: "wasedaSup")
            increaseSup(of: "keioSup")
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 1 {
            appDelegate.sideNum.set(2, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            audienceBack()
            decreaseSup(of: "keioSup")
            increaseSup(of: "audienceSup")
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 2 {
            appDelegate.sideNum.set(0, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            wasedaBack()
            decreaseSup(of: "audienceSup")
            increaseSup(of: "wasedaSup")
        }
    }
    
//  Supporters
    func increaseSup(of side: String) {
        object?.fetchInBackground({ (error) in
            if error != nil {
                
            } else {
                self.object?.incrementKey(side)
                self.object?.saveInBackground({ (error) in
                    if error != nil {
                        
                    } else {
                        
                    }
                })
            }
        })
    }
    
    func decreaseSup(of side: String) {
        object?.fetchInBackground({ (error) in
            if error != nil {
                
            } else {
                self.object?.incrementKey(side, byAmount: -1)
                self.object?.saveInBackground({ (error) in
                    if error != nil {
                        
                    } else {
                        
                    }
                })
            }
        })
    }
    
//  soundChange on SettingView
    @IBAction func onClickToChangeSound(_ sender: Any) {
        if appDelegate.soundNum == 0 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
            makeSound()
        } else if appDelegate.soundNum == 1 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
            makeSound()
        } else if appDelegate.soundNum == 2 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
            makeSound()
        } else if appDelegate.soundNum == 3 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
            makeSound()
        } else if appDelegate.soundNum == 4 {
            appDelegate.soundNum = 0
            soundChangeButtonTitleLabel()
            makeSound()
        }
    }
    
//  standard func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

