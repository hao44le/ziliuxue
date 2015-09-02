//
//  BeforeLoginViewController.swift
//  
//
//  Created by Gelei Chen on 7/12/15.
//
//

import UIKit

class BeforeLoginViewController: UIViewController,UIGestureRecognizerDelegate,UITextFieldDelegate {

    @IBOutlet weak var weiboBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var passwordbackButton: UIButton!
    @IBOutlet weak var passwordInputField: UITextField!

    @IBOutlet weak var usernamebackButton: UIButton!
    @IBOutlet weak var usernameInputfield: UITextField!
    
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    

    @IBOutlet weak var viewPasswordButton: UIButton!
    
    
    @IBOutlet weak var weChatButton: UIButton!
    
    @IBOutlet weak var weiboButton: UIButton!
    
    @IBAction func weiboButtonClicked(sender: UIButton) {
        let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = kWeiboRedirectURI
        request.scope = "all"
        request.userInfo = ["SSO_From":"LoginController"]
        WeiboSDK.sendRequest(request)
    }

    @IBAction func weChatButtonClicked(sender: UIButton) {
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        Tool.showProgressHUD("正在验证")
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "123"
        WXApi.sendReq(req)
    }
    
    @IBAction func viewPasswordButtonClicked(sender: UIButton) {
        self.passwordInputField.secureTextEntry = !self.passwordInputField.secureTextEntry
    }
    
    @IBAction func loginClicked(sender: UIButton) {
        
        if !firstClickOnLogin {
            self.loginActive = true
            self.signupActive = false
            self.firstClickOnLogin = true
            self.setAllHiddenView(false)
            self.loginButton.backgroundColor = UIColor.whiteColor()
            self.loginButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.signupButton.backgroundColor = UIColor.lightGrayColor()
            self.signupButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.loginButton.setTitle("确认登陆", forState: UIControlState.Normal)
            self.signupButton.setTitle("注册", forState: UIControlState.Normal)
        } else {
            if loginActive {
                if usernameInputfield.text == "" {
                    let ac = UIAlertView(title: "请输入邮箱", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                } else if passwordInputField.text == "" {
                    let ac = UIAlertView(title: "请输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                } else {
                    Tool.showProgressHUD("正在验证")
                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                    ServerMethods.obtainToken(self.usernameInputfield.text!, password: self.passwordInputField.text!)
                }
            } else {
                self.loginActive = true
                self.signupActive = false
                self.loginButton.backgroundColor = UIColor.whiteColor()
                self.loginButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
                self.signupButton.backgroundColor = UIColor.lightGrayColor()
                self.signupButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.loginButton.setTitle("确认登陆", forState: UIControlState.Normal)
                self.signupButton.setTitle("注册", forState: UIControlState.Normal)
                self.setAllHiddenView(false)
            }
            
            
        }
        
        
        
    }
    
    @IBAction func signupClicked(sender: UIButton) {
        if !firstClickOnSignup {
            self.signupActive = true
            self.loginActive = false
            self.firstClickOnSignup = true
            self.setAllHiddenView(false)
            
            self.loginButton.backgroundColor = UIColor.lightGrayColor()
            self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.signupButton.backgroundColor = UIColor.whiteColor()
            self.signupButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            
            self.signupButton.setTitle("确认注册", forState: UIControlState.Normal)
            self.loginButton.setTitle("登陆", forState: UIControlState.Normal)
            
        } else {
            if signupActive {
                //error checking
                if usernameInputfield.text == "" {
                    let ac = UIAlertView(title: "请输入邮箱/手机号", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                    return
                }
                
                if passwordInputField.text == "" {
                    let ac = UIAlertView(title: "请输入密码", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                    return
                }
                
                let input = usernameInputfield.text
                if isValidEmail(input) || validatePhoneNumber(input){
                    //signup
                    
                    Tool.showProgressHUD("正在注册")
                    UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                    ServerMethods.signup("", password: passwordInputField.text!,email:usernameInputfield.text!)
                    
                } else {
                    let ac = UIAlertView(title: "邮箱/手机号输入不合法", message: nil, delegate: nil, cancelButtonTitle: "好的")
                    ac.show()
                    return
                }

            } else {
                self.signupActive = true
                self.loginActive = false
                self.loginButton.backgroundColor = UIColor.lightGrayColor()
                self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.signupButton.backgroundColor = UIColor.whiteColor()
                self.signupButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
                
                self.signupButton.setTitle("确认注册", forState: UIControlState.Normal)
                self.loginButton.setTitle("登陆", forState: UIControlState.Normal)
                self.setAllHiddenView(false)
            }
            
        }
        
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func validatePhoneNumber(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        
        var phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        var result =  phoneTest.evaluateWithObject(value)
        
        return result
        
    }
    var firstClickOnLogin = false
    var firstClickOnSignup = false
    var loginActive = false
    var signupActive = false
    let kWeiboRedirectURI = "https://api.weibo.com/oauth2/default.html"
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        //self.bottomLayout.constant = 40
        //self.weiboBottomLayout.constant = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        setupView()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "weChat_login_Successed", name: "weChat_login_Successed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginSuccessed", name: "loginSuccessed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginFailed", name: "loginFailed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupSuccessed", name: "signupSuccessed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "signupFailed", name: "signupFailed", object: nil)
        // Do any additional setup after loading the view.
    }
    
    func weChat_login_Successed(){
        NSUserDefaults.standardUserDefaults().setObject("weChat", forKey: "loginWay")
        Tool.dismissHUD()
        LocalStore.setLogined()
        self.performSegueWithIdentifier("loginToMain", sender: self)
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    func loginSuccessed(){
        NSUserDefaults.standardUserDefaults().setObject("ziliuxue", forKey: "loginWay")
        NSUserDefaults.standardUserDefaults().setObject(usernameInputfield.text, forKey: "nickName")
        LocalStore.setLogined()
        Tool.dismissHUD()
        self.performSegueWithIdentifier("loginToMain", sender: self)
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    func loginFailed(){
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        Tool.dismissHUD()
        let ac = UIAlertView(title: "账号密码不正确", message: nil, delegate: nil, cancelButtonTitle: "好的")
        ac.show()
    }

    func signupSuccessed(){
        NSUserDefaults.standardUserDefaults().setObject("ziliuxue", forKey: "loginWay")
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        NSUserDefaults.standardUserDefaults().setObject(usernameInputfield.text, forKey: "nickName")
        ServerMethods.obtainToken(self.usernameInputfield.text!, password: self.passwordInputField.text!)
        LocalStore.setLogined()
        //self.activityIndicator.stopAnimating()
        Tool.dismissHUD()
        self.performSegueWithIdentifier("signupToMain", sender: self)
    }
    func signupFailed(){
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        let ac = UIAlertView(title: "注册失败，请再试一次", message: nil, delegate: nil, cancelButtonTitle: "好的")
        ac.show()
        Tool.dismissHUD()
    }
    
    
    func setupView(){
        self.usernameInputfield.delegate = self
        self.passwordInputField.delegate = self
        
        self.passwordInputField.hidden = true
        self.passwordbackButton.hidden = true
        self.usernamebackButton.hidden = true
        self.usernameImage.hidden = true
        self.usernameInputfield.hidden = true
        self.passwordImage.hidden = true
        self.viewPasswordButton.hidden = true
        /*
        weiboButton.layer.cornerRadius = 25
        weiboButton.layer.borderWidth = 0.5
        weiboButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        weChatButton.layer.cornerRadius = 25
        weChatButton.layer.borderWidth = 0.5
        weChatButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        passwordInputField.layer.cornerRadius = 20
        passwordInputField.layer.borderWidth = 0.5
        passwordInputField.layer.borderColor = UIColor.whiteColor().CGColor
        
        passwordbackButton.layer.cornerRadius = 25
        passwordbackButton.layer.borderWidth = 0.5
        passwordbackButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        usernameInputfield.layer.cornerRadius = 20
        usernameInputfield.layer.borderWidth = 0.5
        usernameInputfield.layer.borderColor = UIColor.whiteColor().CGColor
        
        usernamebackButton.layer.cornerRadius = 25
        usernamebackButton.layer.borderWidth = 0.5
        usernamebackButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        loginButton.layer.cornerRadius = 23
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        */
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.usernameInputfield {
            IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 105
        } else {
            IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 60
        }

    }
    
    func setAllHiddenView(option:Bool){
        self.passwordInputField.alpha = 0
        self.usernameInputfield.alpha = 0
        
        
        
        self.passwordInputField.hidden = option
        self.passwordbackButton.hidden = option
        self.usernamebackButton.hidden = option
        self.usernameImage.hidden = option
        self.usernameInputfield.hidden = option
        self.passwordImage.hidden = option
        self.viewPasswordButton.hidden = option
        
        let anim = POPSpringAnimation()
        anim.property = (POPAnimatableProperty.propertyWithName(kPOPViewAlpha)) as! POPAnimatableProperty
        anim.toValue = 1
        anim.name = "alpha"
        self.passwordInputField.pop_addAnimation(anim, forKey: "alpha")
        self.usernameInputfield.pop_addAnimation(anim, forKey: "alpha")
        
        self.usernameInputfield.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        self.navigationController?.navigationBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.hidden = false
        self.navigationController!.interactivePopGestureRecognizer!.delegate = nil
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 10
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
