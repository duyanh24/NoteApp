//
//  NoteTableViewCell.swift
//  NoteApp
//
//  Created by AnhLD on 9/10/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupData(note: Note) {
        titleNoteLabel.text = note.title
        dateLabel.text = Converter.convertDateToString(date: note.time)
    }
}
