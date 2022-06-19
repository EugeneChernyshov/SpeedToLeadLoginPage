//
//  ShowUserInfoViewController.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 18.06.2022.
//

import UIKit

class ShowUserInfoViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSurnameLabel: UILabel!
    
    var userName: String
    var userSurname: String
    
    init(userName: String, userSurname: String) {
        self.userName = userName
        self.userSurname = userSurname
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        userNameLabel.text = userName
        userSurnameLabel.text = userSurname
    }


}
