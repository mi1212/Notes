//
//  NoteViewController + Extention(TextView placeholder).swift
//  Notes
//
//  Created by Mikhail Chuparnov on 26.12.2022.
//

import UIKit

extension NoteViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
