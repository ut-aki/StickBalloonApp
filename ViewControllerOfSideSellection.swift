//
//  ViewControllerOfSideSellection.swift
//  StickBalloonApp
//
//  Created by 藤田晃弘 on 2017/05/15.
//  Copyright © 2017年 T6SDL. All rights reserved.
//

import UIKit
import NCMB

class ViewControllerOfSideSellection: UIViewController {
    
//  NCMB
    let object = NCMBObject(className: "Supporters", objectId: "ZCtQnIb3c1GrUlj6")
        
//  SideSelectButton
    @IBOutlet weak var wasedaButton: UIButton!
    @IBOutlet weak var keioButton: UIButton!
    @IBOutlet weak var audienceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        wasedaButton.layer.cornerRadius = 10
        keioButton.layer.cornerRadius = 10
        audienceButton.layer.cornerRadius = 10
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  segue action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "selectedWaseda" {
            appDelegate.sideNum.set(0, forKey: "sideNum")
            object?.fetchInBackground({ (error) in
                if error != nil {
                    
                } else {
                    self.object?.incrementKey("wasedaSup")
                    self.object?.saveInBackground({ (error) in
                        if error != nil {
                            
                        } else {
                            
                        }
                    })
                }
            })
        } else if identifier == "selectedKeio" {
            appDelegate.sideNum.set(1, forKey: "sideNum")
            object?.fetchInBackground({ (error) in
                if error != nil {
                    
                } else {
                    self.object?.incrementKey("keioSup")
                    self.object?.saveInBackground({ (error) in
                        if error != nil {
                            
                        } else {
                            
                        }
                    })
                }
            })
        } else if identifier == "selectedAudience" {
            appDelegate.sideNum.set(2, forKey: "sideNum")
            object?.fetchInBackground({ (error) in
                if error != nil {
                    
                } else {
                    self.object?.incrementKey("audienceSup")
                    self.object?.saveInBackground({ (error) in
                        if error != nil {
                            
                        } else {
                            
                        }
                    })
                }
            })
        }
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
