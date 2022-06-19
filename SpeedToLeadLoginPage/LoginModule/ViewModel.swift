//
//  ViewModel.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 18.06.2022.
//

import Foundation
import Alamofire
import UIKit

class ViewModel {
    
    //MARK: - Properties
    
    var userModel: UserModel?
    
    var errorClosure: (() -> Void)?
    
    //MARK: - API
    
    func logIn(email: String, password: String, errorHandler: (() -> Void)?) {
        let params: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request("https://testinstance.ispeedtolead.com/api/auth/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response
            in
            switch response.result {
            case .success(let data):
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    
                    /// Pretty printed JSON will help you to debug your parsing, uncomment it if needed.
                    //                    guard let prettyPrintedJson = String(data: jsonData, encoding: .utf8) else {
                    //                        print("Error: Could print JSON in String")
                    //                        return
                    //                    }
                    //                    print(prettyPrintedJson)
                    
                    let _user = try? JSONDecoder().decode(UserModel.self, from: jsonData)
                    
                    self.userModel = _user
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            case .failure(let error):
                print(error)
                errorHandler?()
            }
        }
    }
    
    //MARK: - Navigation
    
    func navigateToUserDetailsVC(currentVC: UIViewController) {
        guard let name = userModel?.user.name, let surname = userModel?.user.surname else { return }
        let vc = ShowUserInfoViewController(userName: name, userSurname: surname)
        vc.modalPresentationStyle = .formSheet
        currentVC.present(vc, animated: true, completion: nil)
    }
}
