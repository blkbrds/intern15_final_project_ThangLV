//
//  Data.Ext.swift
//  MyApp
//
//  Created by PCI0008 on 2/18/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]

extension Data {
    func toJSObject() -> JSONObject {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSONObject {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
