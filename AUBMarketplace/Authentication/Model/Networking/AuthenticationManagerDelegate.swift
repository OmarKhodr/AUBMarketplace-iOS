//
//  AuthenticationManagerDelegate.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/11/20.
//

import Foundation

protocol AuthenticationManagerDelegate {
    func didFailAuthenticationWithError(_ manager: AuthenticationManager, error: Error)
    func didAuthenticate(_ manager: AuthenticationManager, token: String)
}
