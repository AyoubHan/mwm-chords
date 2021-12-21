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
    var name = ""
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

