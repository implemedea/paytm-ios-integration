//
//  TxnTokenModel.swift
//  PaytmIntegration
//
//  Created by Sebastin on 07/06/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import Foundation

// MARK: - TxnTokenModel
struct TxnTokenModel: Codable {
    let head: Head
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let resultInfo: ResultInfo
    let txnToken: String
    let isPromoCodeValid, authenticated: Bool
}

// MARK: - ResultInfo
struct ResultInfo: Codable {
    let resultStatus, resultCode, resultMsg: String
}

// MARK: - Head
struct Head: Codable {
    let responseTimestamp, version, signature: String
}
