//
//  ReusableTextFieldProtocol.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 19.06.2022.
//

import Foundation

protocol ReusableTextFieldProtocol {
    
    //Action
    var rightAction: (() -> Void)? { get set }
    
    //Default text field functions
    func clearTextField()
    func checkState()
    func showSecureText()
}
