//
//  RecordsTableViewController.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import UIKit

class RecordsTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        let record = Game.shared.records[indexPath.row]
        
        cell.textLabel?.text = "Правильных ответов: \(record.result)%"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .medium)
        
        return cell
    }
    
}
