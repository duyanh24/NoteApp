//
//  NoteRealmService.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import RealmSwift

class NoteRealmService {
    static let share = NoteRealmService()
    private let realm = try! Realm()
    
    func fetchData(completion: (Results<Note>) -> ()) {
        do {
            let results = realm.objects(Note.self).sorted(byKeyPath: "time", ascending: false)
            completion(results)
        }
    }
    
    func addNote(note: Note) {
        do {
            try realm.write {
                note.id = getIdMax() + 1
                let object = realm.create(Note.self, value: note, update: .all)
                realm.add(object)
            }
        } catch let error {
            print(error)
        }
    }
    
    func getIdMax() -> Int {
        return realm.objects(Note.self).map { $0.id }.max() ?? 0
    }
    
    func getNoteById(id: Int, completion: (Note?) -> ()) {
        //let results = realm.objects(Note.self).filter("id = '\(id)'")
        let result = realm.object(ofType: Note.self, forPrimaryKey: id)
        completion(result)
    }
    
    func updateNote(id: Int, title: String, content: String) {
        do {
            try realm.write {
                guard let note = realm.object(ofType: Note.self, forPrimaryKey: id) else {
                    return
                }
                note.title = title
                note.content = content
                let object = realm.create(Note.self, value: note, update: .all)
                realm.add(object)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteNote(id: Int) {
        if let noteDelete = realm.object(ofType: Note.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(noteDelete)
            }
        }
    }
}
