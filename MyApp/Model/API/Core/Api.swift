//
//  Api.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static let baseURL = "https://www.themealdb.com/api/json/v1/1"
    }
    
    struct Home { }
    struct CountryDetail { }
    struct FoodList { }
}

extension Api.Path {
    struct Home {
        static var countryPath: String {
            return baseURL/"list.php?a=list"
        }
        static var categoryPath: String {
            return baseURL/"categories.php"
        }
    }
    
    struct CountryDetail {
        static var path: String {
            return baseURL/"filter.php?a="
        }
    }
    
    struct FoodList {
        static var path: String {
            return baseURL/"filter.php?c="
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
