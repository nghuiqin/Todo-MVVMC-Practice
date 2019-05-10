//
//  TextEditorViewModel.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

protocol TextEditorViewModelDelegate: class {
    func inputNumberDidUpdate(text: String)
}

class TextEditorViewModel: NSObject {

    weak var delegate: TextEditorViewModelDelegate?

    // Input Content
    var contentString: String

    // Validation attributes
    let maxLength = 100

    init(string: String = "") {
        self.contentString = string
    }
}

extension TextEditorViewModel: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        contentString = textView.text
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if newText.count > maxLength {
            return false
        }
        delegate?.inputNumberDidUpdate(text: "\(newText.count)/\(maxLength)")
        return true
    }
}
