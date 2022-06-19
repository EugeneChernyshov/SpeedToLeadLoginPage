//
//  NibLoadable.swift
//  SpeedToLeadLoginPage
//
//  Created by Evgeniy Chernyshov on 16.06.2022.
//

import Foundation
import UIKit


public protocol NibLoadable {
    var nibName: String { get set }
    var className: AnyClass { get set }
}

public extension NibLoadable where Self: UIView {

    var nib: UINib {
        let bundle = Bundle(for: className)
        return UINib(nibName: nibName, bundle: bundle)
    }

    func setupFromNib() {
        self.backgroundColor = .clear
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Error loading \(self) from nib")
            
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
}
