//
//  ChordsViewModel.swift
//  mwm-chords
//
//  Created by papuruu on 21/12/2021.
//

import Foundation

class ChordsViewModel {
    
    // MARK: - Completion Typealias
    
    typealias CompletionData = (() -> ())
    
    // MARK: - Public Properties
    
    public var toneNames: [String] = []
    public var keyChords: [String] = []
    public var completionData: CompletionData?
    
    // MARK: - Private Properties
    
    private let chordTonesService = ChordTonesService()
    private let keyChordsService = KeyChordsService()
    
    
    // MARK: - Public Properties
    
    func getTones() {
        chordTonesService.getChordTones { (result) in
            switch result {
            case .success(let namess):
                self.toneNames = namess
                self.getKeys()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getKeys() {
        keyChordsService.getKeyChords { (result) in
            switch result {
            case .success(let suffix):
                self.keyChords = suffix
            case .failure(let error):
                print(error)
            }
            self.completionData?()
        }
    }
}
