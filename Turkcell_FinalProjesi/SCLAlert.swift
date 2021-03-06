//
//  SCLAlert.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import Foundation
import SCLAlertView

class SCLAlert {
    func alertWarning(title:String, message:String)  {
        SCLAlertView().showWarning(title, subTitle: message)
    }
    func alertError(title:String,message:String) {
        SCLAlertView().showError(title, subTitle:message)
    }
    func alertSuccess(title:String,message:String)  {
        SCLAlertView().showTitle(
            title, // Title of view
            subTitle: message,
            timeout: nil,// String of view
            //duration: 2.0, // Duration to show before closing automatically, default: 0.0
            completeText: "Tamam", // Optional button value, default: ""
            style: .success, // Styles - see below.
            colorStyle: 0x1C9470,
            colorTextButton: 0xFFFFFF
        )
    }
    func alertInfo(title:String, message:String)  {
        SCLAlertView().showInfo(title, subTitle: message)
    }
}

