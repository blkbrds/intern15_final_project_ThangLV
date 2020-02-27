//
//  ApiManager.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]
typealias Completion = (Result) -> Void

enum Result {
    case success(Any?)
    case failure(String)
}

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        let headers: [String: String] = [:]
        return headers
    }
}
