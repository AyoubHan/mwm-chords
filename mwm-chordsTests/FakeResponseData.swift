//
//  FakeResponseData.swift
//  mwm-chordsTests
//
//  Created by papuruu on 22/12/2021.
//

import Foundation

class FakeResponseData {
    static  let responseOK = HTTPURLResponse(url: URL(string: "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ChordTonesError: Error {}
    class KeyChordsError: Error {}
    
    static let keyChordsServiceError = KeyChordsError()
    static let chordTonesServiceError = ChordTonesError()
    
    static var chordTonesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Tones", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var keyChordsCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "KeyChords", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let chordTonesIncorrectData = "error".data(using: .utf8)!
    static let keyChordsIncorrectData = "error".data(using: .utf8)!
}
