//
//  ChordsViewController.swift
//  mwm-chords
//
//  Created by papuruu on 17/12/2021.
//

import UIKit

class ChordsViewController: UIViewController {
    
    // let chordViewModel = ChordsViewModel()
    let chordService = ChordsService()
    private var names = [String]() {
        didSet {
            names.sort()
            chordTonesPickerView.reloadAllComponents()
        }
    }
    
    @IBOutlet weak var chordTonesPickerView: UIPickerView!
    @IBOutlet weak var keyChordsPickerView: UIPickerView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChordTones()
    }
    
    @IBAction func callButton(_ sender: UIButton) {
        // chordViewModel.getChordTones
        chordService.getChordTones { (result) in
            switch result {
            case .success(let names):
                DispatchQueue.main.async {
                    print(names)
                }
                
            case .failure(_ ):
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    private func loadChordTones() {
        chordService.getChordTones { (result) in
            switch result {
            case .success(let namess):
                print(namess)
                self.names = namess
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ChordsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView.tag == 1
        return names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
    }
}
