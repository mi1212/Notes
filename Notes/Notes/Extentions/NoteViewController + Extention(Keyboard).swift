//
//  NoteViewController + Extention.swift
//  Notes
//
//  Created by Mikhail Chuparnov on 26.12.2022.
//

import UIKit

extension NoteViewController {

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            notificationCentre.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            notificationCentre.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            notificationCentre.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            notificationCentre.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        @objc private func kbdShow(notification: NSNotification) {
            if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                textTextView.contentInset.bottom = kbdSize.height * 1
                textTextView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
            }
        }

        @objc private func kbdHide() {
            textTextView.contentInset = .zero
            textTextView.verticalScrollIndicatorInsets = .zero
        }
}
