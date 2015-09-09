//
//  BeforeLoginViewController.swift
//  
//
//  Created by Gelei Chen on 7/12/15.
//
//

import UIKit

class BeforeLoginViewController: UIViewController,UIGestureRecognizerDelegate,UITextFieldDelegate {

    @IBOutlet weak var viewPasswordWidth: NSLayoutConstraint!
    @IBOutlet weak var viewPasswordHeight: NSLayoutConstraint!
    @IBOutlet weak var equalConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wechatHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var weiboHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstriant: NSLayoutConstraint!
    
    @IBOutlet weak var bottomLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordInputField: UITextField!

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
        
        if WXApi.isWXAppInstalled() {
            Tool.showProgressHUD("正在验证")
            
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "123"
            WXApi.sendReq(req)
        } else {
            Tool.showErrorHUD("没有安装微信")
            
        }
        
        
    }
    
    @IBAction func viewPasswordButtonClicked(sender: UIButton) {
        if sender.tag == 0 {
            Tool.showSuccessHUD("用户忘记了密码，UI还需要设计")
        } else {
            self.passwordInputField.secureTextEntry = !self.passwordInputField.secureTextEntry
        }
        
    }
    
    @IBAction func loginClicked(sender: UIButton) {
        
        if !firstClickOnLogin {
            self.loginActive = true
            self.signupActive = false
            self.firstClickOnLogin = true
            self.setAllHiddenView(false)
            self.updateViewConstraints()
            self.viewPasswordButton.setImage(UIImage(named: "forget_pw"), forState: UIControlState.Normal)
            self.viewPasswordButton.tag = 0
            self.viewPasswordButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit

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
                self.viewPasswordButton.setImage(UIImage(named: "forget_pw"), forState: UIControlState.Normal)
                self.viewPasswordButton.tag = 0
                self.viewPasswordButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit

                self.loginActive = true
                self.signupActive = false
                self.updateViewConstraints()
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
            self.viewPasswordButton.setImage(UIImage(named: "show_password"), forState: UIControlState.Normal)
            self.viewPasswordButton.tag = 1
            self.viewPasswordButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
            self.updateViewConstraints()
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
                self.viewPasswordButton.setImage(UIImage(named: "show_password"), forState: UIControlState.Normal)
                self.viewPasswordButton.tag = 1
                self.viewPasswordButton.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.signupActive = true
                self.loginActive = false
                self.loginButton.backgroundColor = UIColor.lightGrayColor()
                self.loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.signupButton.backgroundColor = UIColor.whiteColor()
                self.signupButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
                self.updateViewConstraints()
                self.signupButton.setTitle("确认注册", forState: UIControlState.Normal)
                self.loginButton.setTitle("登陆", forState: UIControlState.Normal)
                self.setAllHiddenView(false)
            }
            
        }
        
    }
    
    
    func isValidEmail(testStr:String) -> Bool {

        
        let emailRegex = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$"
        let emailPre = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPre.evaluateWithObject(testStr)
    }
    
    func validatePhoneNumber(value: String) -> Bool {
        
        let phoneRegex = "^(0?1[0-9]\\d{9})$|^((0(10|2[1-3]|[3-9]\\d{2}))-?[1-9]\\d{6,7})$"
        let phonePre = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePre.evaluateWithObject(value)
        
    }
    var firstClickOnLogin = false
    var firstClickOnSignup = false
    var loginActive = false
    var signupActive = false
    let kWeiboRedirectURI = "https://api.weibo.com/oauth2/default.html"
    var viewChaned = false
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.equalConstraint.constant = 0
        if DeviceType.IS_IPHONE_4_OR_LESS {
            self.imageViewConstraint.constant = 10
            self.bottomConstriant.constant = 50
            self.bottomLabelConstraint.constant = 50
        } else if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P {
            self.weiboHeightConstraint.constant = 45
            self.wechatHeightConstraint.constant = 45
            self.loginHeightConstraint.constant = 45
            self.bottomConstriant.constant = 120
            self.bottomLabelConstraint.constant = 120
        } else if DeviceType.IS_IPHONE_5 {
            self.imageViewConstraint.constant = 60
        }
        
        if firstClickOnLogin {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.equalConstraint.constant = -100
            })
            self.viewPasswordHeight.constant = 15
            self.viewPasswordWidth.constant = 20
            
        }
        
        if firstClickOnSignup {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.equalConstraint.constant = 100
            })
            self.viewPasswordHeight.constant = 10
            self.viewPasswordWidth.constant = 17
            
        }
        
        if loginActive {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.equalConstraint.constant = -100
            })
            self.viewPasswordHeight.constant = 15
            self.viewPasswordWidth.constant = 20
        }
        
        if signupActive {
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.equalConstraint.constant = 100
            })
            self.viewPasswordHeight.constant = 10
            self.viewPasswordWidth.constant = 17
        }
        
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
        
        LocalStore.setLogined()
        Tool.dismissHUD()
        showPopUpWindow()
        
    }
    
    
    func showPopUpWindow(){
        self.usernameInputfield.resignFirstResponder()
        self.passwordInputField.resignFirstResponder()
        
        let imageView = UIImageView(image: UIImage(named: "pop_up_window"))
        imageView.frame = CGRectMake((ScreenSize.SCREEN_WIDTH - 249)/2, 0, 249, 184)
        
        
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake((ScreenSize.SCREEN_WIDTH - 249)/2, (ScreenSize.SCREEN_HEIGHT - 300), 249, 184)
        button.backgroundColor = UIColor.clearColor()
        button.userInteractionEnabled = true
        button.addTarget(self, action: "pop_up_window_touched", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(imageView)
        self.view.addSubview(button)
        
        
        
        
        let bgTollbar = UIToolbar(frame: self.view.frame)
        bgTollbar.barStyle = UIBarStyle.Black
        self.view.insertSubview(bgTollbar, belowSubview: imageView)
        
        
        let anim = POPSpringAnimation()
        
        anim.springBounciness = 17
        
        anim.property = (POPAnimatableProperty.propertyWithName(kPOPLayerPositionY)) as! POPAnimatableProperty
        anim.toValue = (ScreenSize.SCREEN_HEIGHT - 300)
        anim.name = "y-postion"
        imageView.pop_addAnimation(anim, forKey: "y-postion")
        
        // Delay 3 seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            if self.viewChaned == false {
                self.performSegueWithIdentifier("loginToMain", sender: self)
                
            }
            
        }
        
        
    }
    
    func pop_up_window_touched(){
        self.viewChaned = true
        self.performSegueWithIdentifier("loginToMain", sender: self)
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
        self.usernameImage.hidden = true
        self.usernameInputfield.hidden = true
        self.passwordImage.hidden = true
        self.viewPasswordButton.hidden = true
        self.userView.hidden = true
        self.passwordView.hidden = true
        
        let str = NSAttributedString(string: "请输入手机号或邮箱", attributes: [NSForegroundColorAttributeName:UIColor(white: 1, alpha: 0.7)])
        self.usernameInputfield.attributedPlaceholder = str
        
        
        let string = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:UIColor(white: 1, alpha: 0.7)])
        self.passwordInputField.attributedPlaceholder = string
        
        if DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P {
            self.signupButton.layer.cornerRadius = 24
            self.loginButton.layer.cornerRadius = 24
        } else {
            self.signupButton.layer.cornerRadius = 21
            self.loginButton.layer.cornerRadius = 21
        }
       
        
        self.usernameInputfield.layer.borderWidth = 2
        self.usernameInputfield.layer.borderColor = UIColor.whiteColor().CGColor
        self.passwordInputField.layer.borderWidth = 2
        self.passwordInputField.layer.borderColor = UIColor.whiteColor().CGColor
        self.usernameInputfield.layer.cornerRadius = 20
        self.passwordInputField.layer.cornerRadius = 20
        self.userView.layer.cornerRadius = 20
        self.passwordView.layer.cornerRadius = 20

        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.usernameInputfield {
            IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 100
        } else {
            IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 55
        }

    }
    
    func setAllHiddenView(option:Bool){
        
        
        self.userView.hidden = option
        self.passwordView.hidden = option
        self.passwordInputField.hidden = option
        self.usernameImage.hidden = option
        self.usernameInputfield.hidden = option
        self.passwordImage.hidden = option
        self.viewPasswordButton.hidden = option
        
        
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
