//
//  Tone.swift
//  mwm-chords
//
//  Created by papuruu on 19/12/2021.
//

import Foundation

// MARK: - Tone Struct

struct Tone: Codable {
    let allkeys: [Key]
    let allchords: [Chords]
}

// MARK: - Key Struct

struct Key: Codable {
    let keyid: Int
    let name: String
    let keychordids: [Int]
}

// MARK: - Chords Struct

struct Chords: Codable {
    let midi: [Int]
    let suffix: String
    let fingers: [Int]
    let chordid: Int
}







