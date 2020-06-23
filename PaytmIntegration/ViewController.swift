//
//  ViewController.swift
//  PaytmIntegration
//
//  Created by Sebastin on 24/05/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import UIKit
import AppInvokeSDK
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var txtFldTaxAmt: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldMobile: UITextField!
    
    var checkSum: CheckSumModel?
    var params = [String: String]()
    var orderId: String?
    var customerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFldTaxAmt.text = "10.0"
        txtFldEmail.text = "test@test.com"
        txtFldMobile.text = "9879879876"
        
        self.navigationController?.navigationBar.topItem?.title = "Paytm integration"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let txtAmunt = txtFldTaxAmt.text  else {
            return
        }
        orderId = generateRandomString(length: 5)
        customerId = generateRandomString(length: 6)
        if let tempOrderId = orderId, let tempCustomerId = customerId {
            params = ["mid": PaytmConstants.MID,
                             "orderId": tempOrderId,
                             "custId": tempCustomerId,
                             "value": txtAmunt,
                             "websiteName": PaytmConstants.WEBSITE,
                             "callbackUrl": PaytmConstants.CALLBACK_URL+tempOrderId,
                             "currency": PaytmConstants.CURRENCY,
                             "requestType":PaytmConstants.REQUEST_TYPE_PAYMENT]
        }
    }
    
    
    @IBAction func paytmPayment(_ sender: Any) {
//        callGetSumAPI()
        serviceCallUsingAlmofire()
    }
    
    func generateRandomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func callGetSumAPI() {
           ServiceHandler.sharedServiceHandler.makeServiceCall(strURL: "http://localhost:3001/generate_checksum", param: params) { (data, _, error) in
               if error == nil {
                   guard let data = data else {
                       return
                   }
                let responseJson = try? JSONDecoder().decode(TxnTokenModel.self, from: data)
                print(responseJson as Any);
                
               } else {
                   print(error as Any)
               }
           }
       }
    
    func serviceCallUsingAlmofire() {
        AF.request("http://localhost:3001/generate_checksum", method: .post, parameters: params, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                let responseJson = try? JSONDecoder().decode(TxnTokenModel.self, from: data )
                print("responseJson->",responseJson as Any)
                if let txnToken = responseJson?.body.txnToken {
                    print("txnToken--->",txnToken)
                    AIHandler().openPaytm(merchantId: "nRSgGc54600212058180", orderId: self.params["orderId"] ?? "", txnToken: txnToken, amount: self.params["value"] ?? "", redirectionUrl : self.params["callbackUrl"], delegate: self)
                }
                break
            case .failure(let error):
                print(error as Any)
                break
            }
        }
        
//     AF.request(URL.init(string: "http://192.168.0.5:3000/postmethod")!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            print(response.result)
//
//            switch response.result {
//
//            case .success(_):
//                if let json = response.value
//                {
//                    let responseJson = try? JSONDecoder().decode(CheckSumModel.self, from: json as! Data)
//                    if let checkSum = responseJson?.checksum {
//                        self.beginPayment(checkSum: checkSum, params: self.params)
//                    }
//                }
//                break
//            case .failure(let error):
//                print(error as Any)
//                break
//            }
//        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: AIDelegate {
    func didFinish(with success: Bool, response: [String : Any]) {
        
    }
    
    func openPaymentWebVC(_ controller: UIViewController?) {
        if let vc = controller {
            DispatchQueue.main.async {[weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
}
