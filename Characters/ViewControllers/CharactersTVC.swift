//
//  CharactersTVC.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import UIKit

class CharactersTVC: UITableViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var charArr = [Char]()
    private var locale: String?
    var delegate: SandboxDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        navigationItem.title = "Characters"
        delegate = SandboxManager()
        getChars()
    }

    func getChars() {
        guard let loc = locale else { return }
        ProgressHUD.taskStarted()
        delegate?.getText(by: loc, success: { [weak self] (response, chars) in
            
            ProgressHUD.taskCompleted()
            guard response.success else {
                let errorMessages = response.errors?.compactMap({$0.message + "\n"})
                self?.errorAlert(with: errorMessages?.joined())
                return
            }
            
            let sortedChars = chars.sorted{$0.key < $1.key}
            sortedChars.forEach { (key, value) in
                self?.charArr.append(Char(character: key, quantity: value))
            }

            self?.tableView.reloadData()

        }) { [weak self] (error) in
            ProgressHUD.taskCompleted()
            self?.errorAlert(with: "Request error")
        }
    }
    
    func setLocale(_ locale: String) {
        self.locale = locale
    }
    
}

// MARK: - Table view data source
extension CharactersTVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charArr.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "CharacterCell")
        }
        let char = charArr[indexPath.row]
        cell.textLabel?.text = "\"" + String(char.character) + "\""
        cell.detailTextLabel?.text = String(char.quantity)
     
     return cell
     }

}

struct Char {
    let character: Character
    let quantity: Int
}
