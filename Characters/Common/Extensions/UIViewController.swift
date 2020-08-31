//
//  UIViewController.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import UIKit

extension UIViewController {

    func errorAlert(with message: String?) {
        let alert = UIAlertController()
        alert.title = "Error"
        let action = UIAlertAction(title:"OK", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.message = message
        self.present(alert, animated: true, completion: nil)
    }

}
