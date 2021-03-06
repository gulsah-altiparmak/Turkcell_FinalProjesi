//
//  UIOperations.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 6.02.2021.
//

import Foundation
import UIKit
import Lottie
import Material
class UIOperations {
    let animationView = AnimationView()
    func btnUI(btn:UIButton,title:String) {
        btn.layer.cornerRadius = btn.frame.height / 2

        btn.backgroundColor =  UIColor(red: 253.0/255.0, green: 235/255.0, blue:204.0/255.0, alpha: 1.0)
        btn.clipsToBounds = true
        btn.tintColor = UIColor(red: 73.0/255.0, green: 180.0/255.0, blue: 162.0/255.0, alpha: 1.0)
        btn.setTitle(title, for: .normal)
        
    }
    
    func textViewUI(txtView:UITextView)  {
        txtView.layer.borderWidth = 0.3
        txtView.layer.borderColor = UIColor.lightGray.cgColor
        txtView.layer.cornerRadius=5.5
        txtView.layer.masksToBounds=true
      
    }
    func  splashGradientLayer(view:UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 253.0/255.0, green: 235/255.0, blue:204.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 253.0/255.0, green: 235/255.0, blue:204.0/255.0, alpha: 1.0).cgColor,
           
            UIColor(red: 73.0/255.0, green: 180.0/255.0, blue: 162.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 73.0/255.0, green: 180.0/255.0, blue: 162.0/255.0, alpha: 1.0).cgColor
        ]
        
        
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
        view.layer.addSublayer(gradientLayer)
    }
    
    func gradientLayer(view:UIView,gradientLayer:CAGradientLayer){
      
       
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 253.0/255.0, green: 235/255.0, blue:204.0/255.0, alpha: 1.0).cgColor,
            
       
            
            UIColor(red: 73.0/255.0, green: 180.0/255.0, blue: 162.0/255.0, alpha: 1.0).cgColor
        ]
        
        
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
      
        view.layer.mask = gradientLayer
        view.layer.addSublayer(gradientLayer)
        
    }
    func splashAnimation(view:UIView,animationTitle:String)  {
        animationView.animation = Animation.named(animationTitle)
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    func setupAnimation(isOpened:Bool,view:UIView,animationTitle:String){
       animationView.animation = Animation.named(animationTitle)
       if !(isOpened){
           animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
           animationView.center = view.center
           animationView.contentMode = .scaleAspectFit
           animationView.loopMode = .loop
           animationView.play()
       }else{
           animationView.stop()
           animationView.alpha = 0
           animationView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
       }
     
       view.addSubview(animationView)
   }
    

    func getCachedImageUrl(url:String, width:Int, height:Int) -> String
    {
                var cachedUrl = "https://images.weserv.nl/?url=\(url)"
                cachedUrl += width != 0 ? "&w=\(width)" : ""
                cachedUrl += height != 0 ? "&h=\(height)" : ""
                return cachedUrl
    }
    
    
    func textFieldUI(placeHolder:String, icon:UIImage,txtField:TextField)->TextField{
        
        txtField.placeholder = placeHolder
        txtField.isClearIconButtonEnabled = true
        txtField.isPlaceholderUppercasedWhenEditing = false
        txtField.placeholderAnimation = .default
        txtField.textInsets.left = 8
        txtField.leftViewOffset = -8
        txtField.placeholderNormalColor = UIColor(red: 73.0/255.0, green: 180.0/255.0, blue: 162.0/255.0, alpha: 1.0)
        txtField.dividerNormalColor = Color.cyan.base
        let leftView = UIImageView()
        leftView.image = icon
        txtField.leftView = leftView
        return txtField
    }
    func passwordTextFieldUI(placeHolder:String, icon:UIImage,passTxt1:TextField)->TextField{
        var passTxt = textFieldUI(placeHolder: placeHolder, icon: icon, txtField: passTxt1)
        passTxt.clearButtonMode = .whileEditing
        passTxt.isVisibilityIconButtonEnabled = true
        passTxt.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passTxt.isSecureTextEntry ? 0.38 : 0.54)
        return passTxt
    }
    
    
}
