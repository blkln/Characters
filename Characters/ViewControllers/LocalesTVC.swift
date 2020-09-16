//
//  LocalesTVC.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import UIKit

class LocalesTVC: UITableViewController {

    var delegate: AuthenticationDelegate?
    private var selectedLocale: String?
    
    //    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocaleCell")
        navigationItem.title = "Select locale"
        delegate = AuthManager()
    }

    //    MARK: - Actions
    @IBAction func logoutAction(_ sender: Any) {
        ProgressHUD.taskStarted()
        delegate?.logout(success: { [weak self] (response) in
            
            ProgressHUD.taskCompleted()
            guard response.success else {
                let errorMessages = response.errors?.compactMap({$0.message + "\n"})
                self?.errorAlert(with: errorMessages?.joined())
                return
            }
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.setRootView(storyboard.instantiateInitialViewController()!)

        }) { [weak self] (error) in
            ProgressHUD.taskCompleted()
            self?.errorAlert(with: "Request error")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CharactersTVC,
            let locale = selectedLocale
            else { return }
        destination.setLocale(locale)
    }

}

// MARK: - Table view data source
extension LocalesTVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.localeCodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocaleCell", for: indexPath)
        
        cell.textLabel?.text = Constants.localeCodes[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

// MARK: - Table view delegate
extension LocalesTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocale = Constants.localeCodes[indexPath.row]
        performSegue(withIdentifier: "gotoCharactersTVC", sender: self)
    }
    
}
