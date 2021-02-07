//
//  Constants.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 25/12/20.
//

import Foundation

struct Constants {
    static let baseURL = infoForKey("baseURL")
    static let apiKey = infoForKey("apiKey")
}

func infoForKey(_ key: String) -> String {
        return Bundle.main.infoDictionary?[key] as! String
 }
