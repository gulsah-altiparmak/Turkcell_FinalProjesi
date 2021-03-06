//
//  Register.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import UIKit
import Alamofire
import Material
class Register: UIViewController {

    fileprivate var emailField: TextField!
    fileprivate var passwordField: TextField!
    fileprivate var nameField: TextField!
    fileprivate var surnameField: TextField!
    fileprivate var phoneField: TextField!
    @IBOutlet weak var appNameImg: UIImageView!
    fileprivate let constant: CGFloat = 32
    let ui = UIOperations()
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var outletRegister: UIButton!
   
    let gradientLayer = CAGradientLayer()
    let alert = SCLAlert()
    @IBAction func btnRegister(_ sender: UIButton) {
        let name = nameField.text!.lowercased()
        let surname = surnameField.text!.lowercased()
        let phone = phoneField.text!
        let email = emailField.text!.lowercased()
        let pass = passwordField.text!
        guard !(fncIsValid(name : name, surname : surname,phone: phone,email: email, pass: pass)) else {
            let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24","userName":name,"userSurname":surname,"userPhone":phone,"userMail":email,"userPass":pass]
            
            let url = "https://jsonbulut.com/json/userRegister.php"
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                print(res.response!.statusCode)
                //standart response for successful HTTP protokol
                if (res.response?.statusCode == 200){
                    // print(res.data!)
                    let userRegister = try? JSONDecoder().decode(UserRegister.self, from: res.data!)
                    print(res.value!)
                    let status = userRegister?.user?[0].durum
                    let message = userRegister?.user?[0].mesaj
                    
                    if (status == true){
                        //user login success
                        print(message!)
                        UserDefaults.standard.setValue(String((userRegister?.user?[0].kullaniciId)!), forKey: "userId")
                        print(String((userRegister?.user?[0].kullaniciId)!))
                        self.performSegue(withIdentifier: "productRegister", sender: nil)
                        self.clearTextFields()
                        
                    }else{
                      
                        self.alert.alertError(title: "Hata", message: message!)
                    }
                }
            }
            return
        }
    }
    func clearTextFields()  {
        nameField.text = ""
        passwordField.text = ""
        phoneField.text = ""
        emailField.text = ""
        surnameField.text = ""
    }
    override func viewDidLoad() {
        prepareNameField()
        prepareSurnameField()
        preparePhoneField()
        prepareEmailField()
        preparePasswordField()
        ui.gradientLayer(view: view, gradientLayer: gradientLayer)
        //ui.btnUI(btn: outletRegister,title: "Kaydol")
        addComponentsRegisterView()
        super.viewDidLoad()
    }
    
    func fncIsValid(name:String,surname:String,phone:String,email:String,pass:String) -> (Bool) {
      
        guard name != "" ,surname != "",phone != "", email != "" , pass != "" else {
            alert.alertWarning(title: "Uyarı", message: "Lütfen yukarıdaki alanları boş bırakmayın.")
            
            return false
        }
        return true
    }

    func addComponentsRegisterView() {
        nameField.layer.mask = gradientLayer
        surnameField.layer.mask = gradientLayer
        phoneField.layer.mask = gradientLayer
        emailField.layer.mask = gradientLayer
        passwordField.layer.mask = gradientLayer
        outletRegister.layer.mask = gradientLayer
        appNameImg.layer.mask = gradientLayer
        view.addSubview(nameField)
        view.addSubview(surnameField)
        view.addSubview(phoneField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(outletRegister)
        view.addSubview(appImage)
        view.addSubview(appNameImg)
    }


}
extension Register {
    fileprivate func prepareNameField() {
        nameField = TextField()
        nameField =  ui.textFieldUI(placeHolder: "İsim", icon: Icon.favorite!, txtField: nameField)
        view.layout(nameField).center(offsetY:  -60).left(20).right(20)
    }
    fileprivate func prepareSurnameField() {
        surnameField = TextField()
        surnameField =  ui.textFieldUI(placeHolder: "Soyisim", icon: Icon.favorite!, txtField: surnameField)
        view.layout(surnameField).center(offsetY:0).left(20).right(20)
    }
    fileprivate func preparePhoneField() {
        phoneField = TextField()
        phoneField =  ui.textFieldUI(placeHolder: "Telefon", icon: Icon.phone!, txtField: phoneField)
        
        view.layout(phoneField).center(offsetY: 60).left(20).right(20)
    }
    fileprivate func prepareEmailField() {
        emailField = TextField()
        emailField =  ui.textFieldUI(placeHolder: "Email", icon: Icon.email!, txtField: emailField)
        view.layout(emailField).center(offsetY: 120).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField =  ui.passwordTextFieldUI(placeHolder: "Şifre", icon: Icon.cm.pen!, passTxt1: passwordField)
        view.layout(passwordField).center(offsetY: 180).left(20).right(20)
        
    }
}

