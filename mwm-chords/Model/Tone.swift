//
//  Tone.swift
//  mwm-chords
//
//  Created by papuruu on 19/12/2021.
//

import Foundation

struct Tone: Codable {
    let allkeys: [Key]
    let allchords: [Chords]
}

struct Key: Codable {
    let keyid: Int
    let name: String
    let keychordids: [Int]
}

struct Chords: Codable {
    let midi: [Int]
    let suffix: String
    let fingers: [Int]
    let chordid: Int
}







