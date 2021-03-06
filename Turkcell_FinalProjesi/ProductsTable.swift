//
//  ProductsTable.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 31.01.2021.
//

import UIKit
import Alamofire
import Lottie
import SCLAlertView

class ProductsTable: UITableViewController, UISearchBarDelegate {
    var arr: [BilgilerProduct]? = []
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData: [BilgilerProduct] = []
  
    let ui = UIOperations()
    var isOpen:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        filteredData = arr!
        ui.setupAnimation(isOpened: isOpen,view: view,animationTitle: "loading")
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            let params = [ "ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "start":"0" ]
            
            let url = "https://jsonbulut.com/json/product.php"
            
            //alamofire
            //servis ziyaret edildikten sonra gelen sonuçlar res içinde olacak.
            AF.request(url, method: .get, parameters: params).responseJSON { [self] (res) in
                //standart response for successful HTTP protokol
                if (res.response?.statusCode == 200){
                    //print(res.response?.statusCode)
                    //print(res.value!)
                    //print(res.data!)
                    let product = try? JSONDecoder().decode(Products.self, from: res.data!)
                    
                    let status = product?.products[0].durum
                    let message = product?.products[0].mesaj
                    
                    if (status == true){
                        //user login success
                        print(message!)
                        self.arr = product?.products[0].bilgiler
                        self.tableView.reloadData()
                        self.isOpen = true
                        ui.setupAnimation(isOpened: isOpen,view: view,animationTitle: "loading")
                   
                   
                    }else{
                        print(message!)
                    }
                }
            }
        }

    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 145
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if filteredData.count > 0 {
            return filteredData.count
          } else {
            return arr!.count
          }
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.productView.layer.cornerRadius = cell.productView.frame.height / 2
        cell.productImg.layer.cornerRadius = cell.productImg.frame.height / 2
        let item:BilgilerProduct
        if filteredData.count > 0 {
            item = filteredData[indexPath.row]
          } else {
            item = arr![indexPath.row]
          }
        
        DispatchQueue.main.async {
            let urlString = item.images[0].normal
            let cache = self.ui.getCachedImageUrl(url: urlString, width: 0, height: 0)
            let url = URL(string: cache)
            let data = try! Data(contentsOf: url!)
            cell.productImg?.image = UIImage(data: data)
        }
        cell.productName.text = item.productName
        if  item.price != nil {
            cell.productPrice.text = "\(item.price ?? "" )₺"
        }
       
       

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender : BilgilerProduct
        if filteredData.count > 0 {
            sender = filteredData[indexPath.row]
          } else {
             sender = arr![indexPath.row]
          }
      
        performSegue(withIdentifier: "productDetail", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail"{
            let vc = segue.destination as! ProductDetail
            vc.product = (sender as! BilgilerProduct)
        }
    }
    @IBAction func btnOrderList(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "gotoOrderList", sender: nil)
    }
    
  
    @IBAction func btn_logout(_ sender: UIBarButtonItem) {

        let alertView = SCLAlertView()
      
        alertView.addButton("Evet") {
            self.performSegue(withIdentifier: "loginVC", sender: nil)
            print("çalıştı")
        }
        alertView.showSuccess("Uyarı", subTitle: "Çıkış yapmak istediğinizden emin misiniz?")
    
      
        
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == ""{
            filteredData = arr!
        }
        else{
            for item in arr!{
                if item.productName.lowercased().contains(searchText.lowercased()){
                    filteredData.append(item)
                }
            }
        }
      
        self.tableView.reloadData()
        
    }
    
   
    


}
