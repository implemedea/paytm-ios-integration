//
//  SharedClass.swift
//  SampleUITest
//
//  Created by Sebastin on 25/10/18.
//  Copyright © 2018 Sebastin. All rights reserved.
//

import UIKit

class SharedClass: NSObject {
    
    static let sharedInstance = SharedClass()
    
    private override init() {
        
    }
    
    /**
     * Show alert
     * input param - title, message, parent view controller, ok text, cancel text, closure ok, closure cancel
     * output param - ok completion handler, cancel completion handler
     */
    
    func showAlert(title: String, message: String, presenter: UIViewController, actionOk: String?, actionCancel: String?, completionOk: @escaping () -> Void, completionCancel: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let okTitle = actionOk {
            let actionOk = UIAlertAction(title: okTitle, style: .default) { (_) in
                completionOk()
            }
            alert.addAction(actionOk)
        }
        if let cancel = actionCancel {
            let actionCancel = UIAlertAction(title: cancel, style: .default) { (_) in
                completionCancel()
            }
            alert.addAction(actionCancel)
        }
        presenter.present(alert, animated: true, completion: nil)
       
    }
}
