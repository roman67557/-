//
//  FifthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import UIKit

private struct SettingsTable {
    
    var settingsArray: [String]?
    var title: String?
    
    init(settingsArray: [String], title: String) {
        self.settingsArray = settingsArray
        self.title = title
    }
    
}

class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    fileprivate var settingsTable = [SettingsTable]()
    private var myTableView = UITableView()
    private let searchController = UISearchController()
    private var identifierOfCell = "Cell"
    private var secondIdentifier = "Cell2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Options"
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        arrayAppend()
        createTableVIe()
    }
    
    func arrayAppend() {
        settingsTable.append(SettingsTable.init(settingsArray: ["Роман Бажан"], title: "First"))
        settingsTable.append(SettingsTable.init(settingsArray: ["Авиарежим", "Wi-Fi", "Bluetooth", "Сотовая связь", "Режим модема", "VPN"], title: "Second"))
        settingsTable.append(SettingsTable.init(settingsArray: ["Основные", "Пункт управления", "Экран и яркость", "Экран \"Домой\"", "Универсальный доступ", "Обои", "Siri и поиск", "Face ID и код-пароль",  "Экстренный вызов - SOS", "Уведомления о контакте", "Аккумулятор", "Конфиденциальность"], title: "Third"))
   }
    
    func createTableVIe() {
        myTableView = UITableView(frame: view.bounds, style: .insetGrouped)
        myTableView.register(FirstTableViewCell.self, forCellReuseIdentifier: identifierOfCell)
        myTableView.register(SecondTableViewCell.self, forCellReuseIdentifier: secondIdentifier)
        myTableView.register(ThirdTableViewCell.self, forCellReuseIdentifier: "Cell3")
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myTableView)
    }
    
    //    DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsTable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTable[section].settingsArray?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: identifierOfCell, for: indexPath) as! FirstTableViewCell
            cell1.textLabel?.text = settingsTable[indexPath.section].settingsArray?[indexPath.row]
            cell1.detailTextLabel?.text = "Apple ID, iCloud, контент и покупки"
            cell1.imageView?.image = UIImage(named: "me")
            cell1.imageView?.translatesAutoresizingMaskIntoConstraints = false
            cell1.imageView?.leftAnchor.constraint(equalTo: cell1.leftAnchor, constant: 15).isActive = true
            cell1.imageView?.topAnchor.constraint(equalTo: cell1.topAnchor, constant: 7.5).isActive = true
            cell1.imageView?.widthAnchor.constraint(equalToConstant: 85.0).isActive = true
            cell1.imageView?.heightAnchor.constraint(equalToConstant: 85.0).isActive = true
            cell1.imageView?.layer.cornerRadius = 42
            cell1.imageView?.clipsToBounds = true
            cell1.accessoryType = .disclosureIndicator
            cell1.imageView?.contentMode = .scaleAspectFill
            return cell1
            
        } else if indexPath.section == 1 {
            
            if indexPath.row != 0 {
                
                let cell2 = tableView.dequeueReusableCell(withIdentifier: secondIdentifier, for: indexPath) as! SecondTableViewCell
                cell2.textLabel?.text = settingsTable[indexPath.section].settingsArray?[indexPath.row]
                cell2.accessoryType = .disclosureIndicator
                return cell2
                
            } else {
                
                let cell2 = tableView.dequeueReusableCell(withIdentifier: secondIdentifier, for: indexPath) as! SecondTableViewCell
                cell2.textLabel?.text = settingsTable[indexPath.section].settingsArray?[indexPath.row]
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
                cell2.accessoryView = switchView
                cell2.selectionStyle = .none
                return cell2
            }
            
        } else {
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as! ThirdTableViewCell
            cell3.textLabel?.text = settingsTable[indexPath.section].settingsArray?[indexPath.row]
            cell3.accessoryType = .disclosureIndicator
            return cell3
            
        }
        
//        let cell1 = tableView.dequeueReusableCell(withIdentifier: identifierOfCell,
//                                                  for: indexPath) as! FirstTableViewCell
//
//
//        cell1.textLabel?.text = settingsTable[indexPath.section].settingsArray?[indexPath.row]
//        cell1.imageView?.image = UIImage(named: "like")
//        switch (indexPath.section, indexPath.row) {
//
//        case (0, 0):
//            cell1.detailTextLabel?.text = "Parameters of account"
//
//
//
//        case (1,0):
//            let switchView = UISwitch(frame: .zero)
//            switchView.setOn(false, animated: true)
//            switchView.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
//            cell1.accessoryView = switchView
//            cell1.selectionStyle = .none
//
//
//        default:
//            cell1.accessoryView = .none
//            cell1.accessoryType = .disclosureIndicator
//        }
//
//        return cell1
        
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 100.0
        } else {
            return 50.0
        }
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("ON")
            myTableView.backgroundColor = .yellow
        } else {
            print("OFF")
            myTableView.backgroundColor = .systemGray6
            
        }
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            // remove the item from the data model
//            settingsTable.remove(at: indexPath.row)
//
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//            // Not used in our example, but if you were adding a new row, this is where you would do it.
//        }
//    }
    
}

extension FifthViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 3 {
            
        }
    }
    
}
