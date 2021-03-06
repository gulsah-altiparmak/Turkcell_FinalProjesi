//
//  Login.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import UIKit
import Alamofire
import Material
import PMSuperButton
class Login: UIViewController {
    let alert = SCLAlert()
    
    let gradientLayer = CAGradientLayer()
    @IBOutlet weak var appNameImg: UIImageView!
    let ui = UIOperations()
    fileprivate var emailField: TextField!
    fileprivate var passwordField: TextField!
    fileprivate let constant: CGFloat = 32
    @IBOutlet weak var appImg: UIImageView!
    @IBOutlet weak var outletLogin: UIButton!
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        let email = emailField.text!.lowercased()
        let pass = passwordField.text!
       
       
        guard !(fncIsValid(email: email, pass: pass)) else {
            let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24","userEmail":email
                          ,"userPass":pass, "face":"no"]
            
            let url = "https://jsonbulut.com/json/userLogin.php"
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                //standart response for successful HTTP protokol
                if (res.response?.statusCode == 200){
                    // print(res.data!)
                    let userLogin = try? JSONDecoder().decode(UserLogin.self, from: res.data!)
                    
                    let status = userLogin?.user[0].durum
                    let message = userLogin?.user[0].mesaj
                    
                    if (status == true){
                        //user login success
                        print(message!)
                        UserDefaults.standard.setValue(String((userLogin?.user[0].bilgiler?.userID)!), forKey: "userId")
                        print(String((userLogin?.user[0].bilgiler?.userID)!))
                        self.performSegue(withIdentifier: "productLogin", sender: nil)
                        self.clearFields()
                   
                        
                    }else{
                      
                       self.alert.alertError(title: "Hata", message:message!)
                    }
                }
            }
            return
        }
    }
    
    func clearFields()  {
        emailField.text = ""
        passwordField.text = ""
    }
    override func viewDidLoad() {
        view.backgroundColor = Color.grey.lighten5
        preparePasswordField()
        prepareEmailField()
        ui.gradientLayer(view: view,gradientLayer: gradientLayer)
        //ui.btnUI(btn: outletLogin, title: "Giriş Yap")
        addComponentsLoginView()
       
        super.viewDidLoad()
    }
    
    func addComponentsLoginView()  {
        emailField.layer.mask = gradientLayer
        passwordField.layer.mask = gradientLayer
        outletLogin.layer.mask = gradientLayer
        appImg.layer.mask = gradientLayer
        appNameImg.layer.mask = gradientLayer
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(outletLogin)
        view.addSubview(appImg)
        view.addSubview(appNameImg)
        
    }
    
    func fncIsValid(email:String,pass:String) -> (Bool) {
      
        guard email != "" , pass != "" else {
            alert.alertWarning(title: "Uyarı", message: "Lütfen yukarıdaki alanları boş bırakmayın.")
            
            return false
        }
        return true
    }
}
extension Login {
    fileprivate func prepareEmailField() {
        emailField = TextField()
        emailField =  ui.textFieldUI(placeHolder: "Email", icon: Icon.email!, txtField: emailField)
        view.layout(emailField).center(offsetY: -passwordField.bounds.height - 60).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField =  ui.passwordTextFieldUI(placeHolder: "Şifre", icon: Icon.cm.pen!, passTxt1: passwordField)
        view.layout(passwordField).center().left(20).right(20)
        
    }
}

