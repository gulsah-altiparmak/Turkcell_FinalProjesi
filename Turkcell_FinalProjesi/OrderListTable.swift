//
//  OrderListTable.swift
//  Turkcell_FinalProjesi
//
//  Created by Gulsah Altiparmak on 1.02.2021.
//

import UIKit
import Alamofire


class OrderListTable: UITableViewController,UISearchBarDelegate {
   var orderListArr : [OrderListElement] = []
   let alert = SCLAlert()
    var filteredData: [OrderListElement] = []
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    super.viewDidLoad()
        searchBar.delegate = self
      
        filteredData = orderListArr
     
    }

   func getOrders(){
        if  let customerId = UserDefaults.standard.string(forKey: "userId"){
            let params = [ "ref":"5380f5dbcc3b1021f93ab24c3a1aac24", "musterilerID":customerId]
            
            let url = "https://jsonbulut.com/json/orderList.php"
            
            //alamofire
            //servis ziyaret edildikten sonra gelen sonuçlar res içinde olacak.
            AF.request(url, method: .get, parameters: params).responseJSON { [self] (res) in
                //standart response for successful HTTP protokol
                if (res.response?.statusCode == 200){
                    print(res.response?.statusCode)
                    print(res.value)
                    let orderList = try? JSONDecoder().decode(OrderList.self, from: res.data!)
                    if let orderList1 = orderList?.orderList[0] {
                      
                        self.orderListArr = orderList1
                        self.tableView.reloadData()
                    }
                    else if self.orderListArr.count == 0 {
                        self.alert.alertInfo(title: "Bilgi", message: "Kayıtlı siparişiniz bulunmamaktadır")
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
            return orderListArr.count
          }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! CustomCell
        cell.orderImage.layer.cornerRadius = cell.orderImage.frame.height/2
        cell.orderView.layer.cornerRadius = cell.orderView.frame.height / 2
        let item:OrderListElement
        if filteredData.count > 0 {
            item = filteredData[indexPath.row]
          } else {
            item = orderListArr[indexPath.row]
          }
           // item = orderListArr[indexPath.row]
            cell.orderProductName.text = item.urunAdi
            cell.orderPrice.text = item.fiyat + "₺"
            cell.orderDate.text = String((item.eklenmeTarihi.prefix(10)))
        DispatchQueue.main.async {  
            let urlString = item.normal
            let ui = UIOperations()
            let cache = ui.getCachedImageUrl(url: urlString, width: 0, height: 0)
            let url = URL(string: cache)
            let data = try! Data(contentsOf: url!)
            cell.orderImage.image = UIImage(data: data)
        }
        
        return cell
    }

    override func viewDidAppear(_ animated: Bool) {
      getOrders()
        
      
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == ""{
            filteredData = orderListArr
        }
        else{
            for item in orderListArr{
                if item.urunAdi.lowercased().contains(searchText.lowercased()){
                    filteredData.append(item)
                }
            }
        }
      
        self.tableView.reloadData()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
