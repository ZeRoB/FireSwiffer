//
//  SweetsTableViewController.swift
//  FireSwiffer
//
//  Created by Rob on 23.06.18.
//  Copyright © 2018 zero. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SweetsTableViewController: UITableViewController {

    var dbRef: DatabaseReference?
    var sweets = [Sweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference().child("sweet-items")
        startObservingDB()
    }

    @IBAction func addSweet(_ sender: Any) {
        let sweetAlert = UIAlertController(title: "New Sweet", message: "Enter your Sweet", preferredStyle: .alert)
        sweetAlert.addTextField { (textfield) in
            textfield.placeholder = "Your sweet"
        }
        sweetAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            if let sweetContent = sweetAlert.textFields?.first?.text {
                let sweet = Sweet(content: sweetContent, addedByUser: "Robert Zelhofer")
                let sweetRef = self.dbRef?.child(sweetContent.lowercased())
                sweetRef?.setValue(sweet.toAny())
            }
        }))
        present(sweetAlert, animated: true, completion: nil)
    }
    
    func startObservingDB() {
        dbRef?.observe(.value, with: { (snapshot) in
            var newSweets = [Sweet]()
            for sweet in snapshot.children {
                if let sweetSnapshot =  sweet as? DataSnapshot {
                    let sweetObject = Sweet(snapshot: sweetSnapshot)
                    newSweets.append(sweetObject)
                }
            }
            self.sweets = newSweets
            self.tableView.reloadData()
        }, withCancel: { (error) in
            print("\(error)")
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let sweet = sweets[indexPath.row]
        cell.textLabel?.text = sweet.content
        cell.detailTextLabel?.text = sweet.addedByUser
        return cell
    }

}
