//
//  NoteAddViewController.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class NoteAddViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    private func setupData() {
        guard let note = note else {
            return
        }
        NoteRealmService.share.getNoteById(id: note.id, completion: { result in
            
            titleTextField.text = result?.title
            contentTextView.text = result?.content
        })
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        guard let title = titleTextField.text, title != "" else {
            self.showToast(message : "Chưa nhập chủ đề ")
            return
        }
        guard let note = note else {
            NoteRealmService.share.addNote(note: Note(title: title, content: contentTextView.text ?? ""))
            navigationController?.popViewController(animated: true)
            return
        }
        NoteRealmService.share.updateNote(id: note.id, title: title, content: contentTextView.text ?? "")
        navigationController?.popViewController(animated: true)
    }
}
