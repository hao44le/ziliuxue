//
//  BeforeLoginViewController.swift
//  
//
//  Created by Gelei Chen on 7/12/15.
//
//

import UIKit

class BeforeLoginViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var inputField: UITextField!

    @IBOutlet weak var weChatButton: UIButton!
    
    @IBOutlet weak var weiboButton: UIButton!
    
    @IBAction func weiboButtonClicked(sender: UIButton) {
    }

    @IBAction func weChatButtonClicked(sender: UIButton) {
        
    }
    
    
    @IBAction func loginClicked(sender: UIButton) {
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "自留学", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        weiboButton.layer.cornerRadius = 25
        weiboButton.layer.borderWidth = 0.5
        weiboButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        weChatButton.layer.cornerRadius = 25
        weChatButton.layer.borderWidth = 0.5
        weChatButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        inputField.layer.cornerRadius = 20
        inputField.layer.borderWidth = 0.5
        inputField.layer.borderColor = UIColor.whiteColor().CGColor
        
        backButton.layer.cornerRadius = 25
        backButton.layer.borderWidth = 0.5
        backButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        loginButton.layer.cornerRadius = 25
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationController?.navigationBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.interactivePopGestureRecognizer!.delegate = nil
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
    }
    
    

}
