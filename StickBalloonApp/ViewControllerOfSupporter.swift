//
//  ViewControllerOfSupporter.swift
//  StickBalloonApp
//
//  Created by 藤田晃弘 on 2017/05/15.
//  Copyright © 2017年 T6SDL. All rights reserved.
//

import UIKit
import NCMB

class ViewControllerOfSupporter: UIViewController {
    
//  AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//  Outlet
    @IBOutlet var supporterVC: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var sideChangeButton: UIButton!
    @IBOutlet weak var soundChangeButton: UIButton!
    @IBOutlet weak var sideMemberLabel: UILabel!
    @IBOutlet weak var wasedaSupporterLabel: UILabel!
    @IBOutlet weak var keioSupporterLabel: UILabel!
    @IBOutlet weak var creditsView: UIView!
    
//  NCMB
    var sups = NCMBObject(className: "Supporters", objectId: "ZCtQnIb3c1GrUlj6")
    
//  variable to hide View of Setting
    var flag: Bool!
    
//  View index
    var index: Int = 0

//  standard func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        flag = false
        
        settingView.layer.borderColor = UIColor.red.cgColor
        settingView.layer.borderWidth = 3
        settingView.isHidden = true
        
        creditsView.isHidden = true

        sideChangeButtonTitleLabel()
        soundChangeButtonTitleLabel()
        
        let wasedaSup = self.getSupNum("wasedaSup")
        let keioSup = self.getSupNum("keioSup")
        if appDelegate.sideNum.integer(forKey: "sideNum") == 0 {
            wasedaBack()
            canSeeLabel(ofWaseda: true, ofKeio: true, ofMember: false)
            sideMemberLabel.font = UIFont(name: "Bebas Neue", size: 36)
            sideMemberLabel.textAlignment = NSTextAlignment.center
            sideMemberLabel.text = "WASEDA: \(wasedaSup)人"
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 1 {
            keioBack()
            canSeeLabel(ofWaseda: true, ofKeio: true, ofMember: false)
            sideMemberLabel.font = UIFont(name: "Bebas Neue", size: 36)
            sideMemberLabel.textAlignment = NSTextAlignment.center
            sideMemberLabel.text = "KEIO: \(keioSup)人"
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 2 {
            audienceBack()
            canSeeLabel(ofWaseda: false, ofKeio: false, ofMember: true)
            wasedaSupporterLabel.font = UIFont(name: "Bebas Neue", size: 28)
            wasedaSupporterLabel.textAlignment = NSTextAlignment.center
            wasedaSupporterLabel.text = "WASEDA: \(wasedaSup)人"
            keioSupporterLabel.font = UIFont(name: "Bebas Neue", size: 28)
            keioSupporterLabel.textAlignment = NSTextAlignment.center
            keioSupporterLabel.text = "KEIO: \(keioSup)人"
        }
    }
    
//  BackgroundColor at WASEDA
    func wasedaBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.6932106599, green: 0.1560991657, blue: 0.08986309497, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = supporterVC.bounds
        supporterVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  BackgroundColor at KEIO
    func keioBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.006702585355, green: 0.195407935, blue: 1, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = supporterVC.bounds
        supporterVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  BackgroundColor at AUDIENCE
    func audienceBack() {
        let startColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.8464665292, green: 0.7834377073, blue: 0.08577214193, alpha: 1).cgColor
        let layer = CAGradientLayer()
        layer.colors = [startColor, endColor]
        layer.frame = supporterVC.bounds
        supporterVC.layer.insertSublayer(layer, at: UInt32(index))
        index += 1
    }
    
//  which Label do you see
    func canSeeLabel(ofWaseda: Bool, ofKeio: Bool, ofMember: Bool) {
        wasedaSupporterLabel.isHidden = ofWaseda
        keioSupporterLabel.isHidden = ofKeio
        sideMemberLabel.isHidden = ofMember
    }
    
//  func onClick setting
    @IBAction func onClickSetting(_ sender: UIButton) {
        if !flag {
            settingView.isHidden = false
            flag = true
        } else {
            settingView.isHidden = true
            flag = false
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
            let keioSup = self.getSupNum("keioSup")
            appDelegate.sideNum.set(1, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            keioBack()
            decreaseSup(of: "wasedaSup")
            increaseSup(of: "keioSup")
            sideMemberLabel.font = UIFont(name: "Bebas Neue", size: 36)
            sideMemberLabel.textAlignment = NSTextAlignment.center
            sideMemberLabel.text = "KEIO: \(keioSup)人"
            canSeeLabel(ofWaseda: true, ofKeio: true, ofMember: false)
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 1 {
            let wasedaSup = self.getSupNum("wasedaSup")
            let keioSup = self.getSupNum("keioSup")
            appDelegate.sideNum.set(2, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            audienceBack()
            decreaseSup(of: "keioSup")
            increaseSup(of: "audienceSup")
            wasedaSupporterLabel.font = UIFont(name: "Bebas Neue", size: 28)
            wasedaSupporterLabel.textAlignment = NSTextAlignment.center
            wasedaSupporterLabel.text = "WASEDA: \(wasedaSup)人"
            keioSupporterLabel.font = UIFont(name: "Bebas Neue", size: 28)
            keioSupporterLabel.textAlignment = NSTextAlignment.center
            keioSupporterLabel.text = "KEIO: \(keioSup)人"
            canSeeLabel(ofWaseda: false, ofKeio: false, ofMember: true)
        } else if appDelegate.sideNum.integer(forKey: "sideNum") == 2 {
            let wasedaSup = self.getSupNum("wasedaSup")
            appDelegate.sideNum.set(0, forKey: "sideNum")
            sideChangeButtonTitleLabel()
            wasedaBack()
            decreaseSup(of: "audienceSup")
            increaseSup(of: "wasedaSup")
            sideMemberLabel.font = UIFont(name: "Bebas Neue", size: 36)
            sideMemberLabel.textAlignment = NSTextAlignment.center
            sideMemberLabel.text = "WASEDA: \(wasedaSup)人"
            canSeeLabel(ofWaseda: true, ofKeio: true, ofMember: false)
        }
    }
    
//  sups name
    func getSupNum(_ supName: String) -> Int {
        var supNum: Int = 0
        
        let query = NCMBQuery(className: "Supporters")
        query?.whereKey("objectId", equalTo: "ZCtQnIb3c1GrUlj6")
        var results: [AnyObject] = []
        do {
            results = try query!.findObjects() as [AnyObject]
        } catch  let error1 as NSError  {
            print("\(error1)")
            return supNum
        }
        if results.count > 0 {
            let result = results[0] as? NCMBObject
            supNum = result?.object(forKey: supName) as? Int ?? 0
        }
        return supNum
    }
    
//  Supporters
    func increaseSup(of side: String) {
        sups?.fetchInBackground({ (error) in
            if error != nil {
                
            } else {
                self.sups?.incrementKey(side)
                self.sups?.saveInBackground({ (error) in
                    if error != nil {
                        
                    } else {
                        
                    }
                })
            }
        })
    }
    
    func decreaseSup(of side: String) {
        sups?.fetchInBackground({ (error) in
            if error != nil {
                
            } else {
                self.sups?.incrementKey(side, byAmount: -1)
                self.sups?.saveInBackground({ (error) in
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
        } else if appDelegate.soundNum == 1 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
        } else if appDelegate.soundNum == 2 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
        } else if appDelegate.soundNum == 3 {
            appDelegate.soundNum += 1
            soundChangeButtonTitleLabel()
        } else if appDelegate.soundNum == 4 {
            appDelegate.soundNum = 0
            soundChangeButtonTitleLabel()
        }
    }
    
//  standard func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
