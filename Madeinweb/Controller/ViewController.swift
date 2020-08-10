//
//  ViewController.swift
//  Madeinweb
//
//  Created by Caio  Marastoni on 01/08/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldPesquisa: UITextField!
    
    var searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldPesquisa.delegate = self
        
    }
    
    @IBAction func buttonBuscar(_ sender: UIButton) {
        if textFieldPesquisa.text != ""{
            textFieldPesquisa.endEditing(true)
            performSegue(withIdentifier: K.secondViewSegue, sender: self)
        } else {
            textFieldPesquisa.placeholder = Placeholder.textField
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let search = textFieldPesquisa.text?.replacingOccurrences(of: " ", with: "") {
            searchManager.fetchSearchRequest(searchParameter: search)
        }
        textFieldPesquisa.text = ""
    }

}


