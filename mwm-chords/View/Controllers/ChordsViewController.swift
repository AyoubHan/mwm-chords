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
    let pickerData = PickerData()
    
    @IBOutlet weak var chordTonesPickerView: UIPickerView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIt()
        loadChordTones()
    }
    
    func setIt() {
        chordTonesPickerView.delegate = pickerData
        chordTonesPickerView.dataSource = pickerData
    }
    
    private func loadChordTones() {
        chordService.getChordTones { (result) in
            switch result {
            case .success(let namess):
                self.pickerData.toneNames = namess
                self.loadKeyChords()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadKeyChords() {
        chordService.getKeyChords { (result) in
            switch result {
            case .success(let suffix):
                self.pickerData.keyChords = suffix
            case .failure(let error):
                print(error)
            }
            self.chordTonesPickerView.reloadAllComponents()
        }
    }
}
