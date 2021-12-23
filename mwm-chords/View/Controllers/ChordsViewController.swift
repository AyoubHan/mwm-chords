//
//  ChordsViewController.swift
//  mwm-chords
//
//  Created by papuruu on 17/12/2021.
//

import UIKit

class ChordsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let chordViewModel = ChordsViewModel()
    
    // MARK: - IBOutlets
    
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
    
    // MARK: - Private Methods
    
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
        chordViewModel.getTones()
        chordViewModel.completionData = { [weak self] in
            guard let self = self else { return }
            self.chordTonesPickerView.reloadAllComponents()
        }
    }
}

// MARK: - UIPickerViewDataSource

extension ChordsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if component == 0 {
            count = chordViewModel.toneNames.count
        } else {
            count = chordViewModel.keyChords.count
        }
        return count
    }
}

// MARK: - UIPickerViewDelegate

extension ChordsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowData = ""
        if component == 0 {
            rowData = chordViewModel.toneNames[row]
        } else {
            rowData = chordViewModel.keyChords[row]
        }
        return rowData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tone = chordViewModel.toneNames[pickerView.selectedRow(inComponent: 0)]
        let key = chordViewModel.keyChords[pickerView.selectedRow(inComponent: 1)]
        chordsDataLabel.text = "Tone: \(tone) \nKey: \(key)"
    }
}
