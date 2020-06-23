//
//  Constants.swift
//  PaytmIntegration
//
//  Created by Sebastin on 25/05/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import Foundation

struct PaytmConstants {
    public static let MID = "nRSgGc54600212058180"
    public static let WEBSITE = "WEBSTAGING"
    public static let CHANNEL_ID = "WAP"
    public static let INDUSTRY_TYPE_ID = "Retail"
//    For staging:-
//    "callbackUrl" => "'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId"
//    For production:-
//    "callbackUrl" => "'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=$orderId"

    public static let CALLBACK_URL = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID="
    public static let CURRENCY = "INR"
    public static let REQUEST_TYPE_PAYMENT = "Payment"
}
