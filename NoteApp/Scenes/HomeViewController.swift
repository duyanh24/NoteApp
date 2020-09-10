//
//  ViewController.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var noteTableView: UITableView!
    
    private var listNote: [Note] = [] {
        didSet {
            noteTableView.reloadData()
        }
    }
    private var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        setupObserve()
    }
    
    private func setupTableView() {
        noteTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        noteTableView.dataSource = self
        noteTableView.delegate = self
    }
    
    private func fetchData() {
        NoteRealmService().fetchData(completion: {results in
            listNote = Array(results)
        })
    }
    
    private func setupObserve() {
        let realm = try! Realm()
        notificationToken = realm.objects(Note.self).observe({ [weak self] _ in
            self?.fetchData()
        })
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell, listNote.indices.contains(indexPath.row)
             else {
                return UITableViewCell()
        }
        cell.setupData(note: listNote[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let noteAddViewController = storyboard?.instantiateViewController(withIdentifier: "NoteAddViewController") as? NoteAddViewController, listNote.indices.contains(indexPath.row) else {
            return
        }
        
        let noteSelected = listNote[indexPath.row]
        noteAddViewController.note = noteSelected
        navigationController?.pushViewController(noteAddViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard listNote.indices.contains(indexPath.row) else {
                return
            }
            NoteRealmService.share.deleteNote(id: listNote[indexPath.row].id)
        }
    }
}
