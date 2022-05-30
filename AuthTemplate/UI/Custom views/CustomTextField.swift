//
//  CustomTextField.swift
//  AuthTemplate
//
//  Created by Elbek Khasanov on 26/05/22.
//

import UIKit

class CustomTextField: UIView, UITextFieldDelegate {

    var mainContainer: UIView!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var rightIcon: UIImageView!
    
    var placeholder: String = "Example placeholder" {
        didSet {
            self.tf.placeholder = placeholder
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        baseSetup()
    }
    
    

    private func baseSetup() {

        guard let nib = Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?.first as? UIView else { return }
        
        mainContainer = nib
        configureContainer()
        configureTextField()
        configureRightIcon()
    }
    
    private func configureContainer() {
        mainContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainContainer.frame = bounds
        addSubview(mainContainer)
        
        self.mainContainer.backgroundColor = .white
        self.mainContainer.clipsToBounds = true
        self.mainContainer.layer.cornerRadius = 16
    }
    
    private func configureTextField() {
        self.tf.backgroundColor = .clear
        self.tf.delegate = self
    }
    
    private func configureRightIcon() {
        self.rightIcon.image = UIImage(systemName: "person")
    }
    
    @IBAction func rightIconClicked(_ sender: UIButton) {
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
