//
//  ProgressHUD.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressHUD {
    
    class func taskStarted() {
        guard let window = UIApplication.shared.keyWindow  else { return }
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.label.text = "Loading..."
            hud.minShowTime = 0.5
        }
    }
    
    class func taskCompleted() -> Void {
        guard let window = UIApplication.shared.keyWindow  else { return }
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: window, animated: true)
        }
    }

}
