//
//  NotesViewController.swift
//  Notes
//
//  Created by Ирина on 18.04.2022.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func saveNote(_ note: Notes)
    
}
class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let height: CGFloat = 84
    private var notes: [Notes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        notes = StorageManager.shared.fetchNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newNote" {
            guard let addVC = segue.destination as? AddNoteViewController else { return }
            addVC.delegate = self
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NoteCell" , for: indexPath
        )
        let notes = notes[indexPath.row]
        
        cell.textLabel?.text = notes.title
        cell.detailTextLabel?.text = notes.description
        
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deleteNote(at: indexPath.row)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
     
}

extension NotesViewController: AddNoteViewControllerDelegate {
    func saveNote(_ note: Notes) {
        notes.append(note)
        tableView.reloadData()
    }
}
