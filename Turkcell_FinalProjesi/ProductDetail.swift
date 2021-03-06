//
//  ProductDetail.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import UIKit
import Alamofire

class ProductDetail: UIViewController {

    let alert = SCLAlert()
    var product:BilgilerProduct?
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCategory1: UILabel!
    @IBOutlet weak var productDetail: UITextView!
    
    @IBOutlet weak var outletOrder: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let ui = UIOperations()
        productImage.layer.cornerRadius = 20.0
        productImage.layer.masksToBounds = true
        
        
        ui.textViewUI(txtView: productDetail)
        
        productName.text = product?.productName
        productPrice.text = product!.price + "₺"
        productCategory1.text = product?.categories[0].categoryName
        productDetail.text = product?.bilgilerProductDescription
        
      
        //ui.btnUI(btn: outletOrder, title: "Sipariş Ver")
      
        
        DispatchQueue.main.async { [self] in
            let urlString = self.product?.images[0].normal
            let cache = ui.getCachedImageUrl(url: urlString!, width: 0, height: 0)
            let url = URL(string: cache)
            
            let data = try! Data(contentsOf: url!)
            productImage.image = UIImage(data: data)
        }
    
        

    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        let url = "https://jsonbulut.com/json/orderForm.php"
        UserDefaults.standard.setValue(String(product!.productID), forKey: "productId")
        if let customerId = UserDefaults.standard.string(forKey: "userId"),
           let productId = UserDefaults.standard.string(forKey: "productId")
        {
            let params = ["ref":"5380f5dbcc3b1021f93ab24c3a1aac24","customerId":customerId
                          ,"productId":productId, "html":productId]
            
           
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                //standart response for successful HTTP protokol
                if (res.response?.statusCode == 200){
                    print(res.response?.statusCode)
                    print(res.value!)
                    // print(res.data!)
                  
                    let orders = try? JSONDecoder().decode(Order.self, from: res.data!)
                   
                    let status = orders?.order[0].durum
                    let message = orders?.order[0].mesaj
                    
                    
                    if (status == true){
                        //user login success
                        print(message!)
                        
                        //self.performSegue(withIdentifier: "productLogin", sender: nil)
                        self.alert.alertSuccess(title: "Başarılı", message: message!)
                        //NotificationCenter.default.post(name: NSNotification.Name("veriGirildi"), object: nil)
                        //self.navigationController?.popViewController(animated: true)
                    }else{
                      
                       self.alert.alertError(title: "Hata", message:message!)
                    }
                }
            }
        }
        
     
    }
 

}
