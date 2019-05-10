//
//  TextEditorViewController.swift
//  Todo
//
//  Created by Hui Qin Ng on 2019/5/9.
//

import UIKit

protocol TextEditorViewControllerDelegate: class {
    func textDidSave()
}

class TextEditorViewController: UIViewController {

    weak var delegate: TextEditorViewControllerDelegate?

    private let viewModel: TextEditorViewModel

    private lazy var inputTextView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        return textView
    }()

    private lazy var maxInputLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .gray
        return label
    }()

    init(viewModel: TextEditorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        viewModel.delegate = self
    }

    private func viewSetup() {
        view.backgroundColor = UIColor(white: 250/255, alpha: 1)

        // Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))

        // Input TextView
        view.addSubview(inputTextView)
        inputTextView.delegate = viewModel
        inputTextView.text = viewModel.contentString
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        inputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        inputTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // Input Max Number Label
        view.addSubview(maxInputLabel)
        maxInputLabel.text = "0/\(viewModel.maxLength)"
        maxInputLabel.translatesAutoresizingMaskIntoConstraints = false
        maxInputLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        maxInputLabel.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 10).isActive = true
    }

    @objc func handleSave() {
        delegate?.textDidSave()
    }
}

extension TextEditorViewController: TextEditorViewModelDelegate {
    func inputNumberDidUpdate(text: String) {
        maxInputLabel.text = text
    }
}
