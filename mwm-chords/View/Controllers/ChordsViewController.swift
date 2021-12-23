//
//  ChordsViewController.swift
//  mwm-chords
//
//  Created by papuruu on 17/12/2021.
//

import UIKit

class ChordsViewController: UIViewController {
    
    let chordViewModel = ChordsViewModel()
    var toneNames: [String] = []
    var keyChords: [String] = []
    
    @IBOutlet weak var chordTonesPickerView: UIPickerView!
    @IBOutlet weak var chordsDataLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerview()
        loadChordTones()
        setColors()
        setLabels()
    }
    
    private func setColors() {
        view.backgroundColor = UIColor(named: "background")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "title") ?? ""]
        chordsDataLabel.textColor = UIColor(named: "label")
    }
    
    private func setLabels() {
        chordsDataLabel.text = "Tone: A \nKey: +"
    }

    func setPickerview() {
        chordTonesPickerView.delegate = self
        chordTonesPickerView.dataSource = self
    }
    
    private func loadChordTones() {
        DispatchQueue.main.async {
            self.chordViewModel.chordTonesService.getChordTones { (result) in
                switch result {
                case .success(let namess):
                    self.toneNames = namess
                    self.loadKeyChords()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func loadKeyChords() {
        self.chordViewModel.keyChordsService.getKeyChords { (result) in
            switch result {
            case .success(let suffix):
                self.keyChords = suffix
            case .failure(let error):
                print(error)
            }
            self.chordTonesPickerView.reloadAllComponents()
        }
    }
}

extension ChordsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if component == 0 {
            count = toneNames.count
        } else {
            count = keyChords.count
        }
        return count
    }
}

extension ChordsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowData = ""
        if component == 0 {
            rowData = toneNames[row]
        } else {
            rowData = keyChords[row]
        }
        return rowData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tone = toneNames[pickerView.selectedRow(inComponent: 0)]
        let key = keyChords[pickerView.selectedRow(inComponent: 1)]
        chordsDataLabel.text = "Tone: \(tone) \nKey: \(key)"
    }
}
