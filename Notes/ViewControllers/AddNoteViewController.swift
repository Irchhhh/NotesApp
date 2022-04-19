//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Ирина on 18.04.2022.
//

import UIKit

final class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var delegate: AddNoteViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.addTarget(
            self,
            action: #selector(titleTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        saveNotes()
    }
    
    @objc func titleTextFieldDidChanged() {
        guard let titleText = titleTextField.text else { return }
        doneButton.isEnabled = !titleText.isEmpty
    }
    
    private func saveNotes() {
        guard let title = titleTextField.text else { return }
        guard let detailsText = detailsTextView.text else { return }
        
        let note = Notes(title: title, description: detailsText)
        
        StorageManager.shared.save(note: note)
        delegate.saveNote(note)
        dismiss(animated: true)
    }
}

    

   


