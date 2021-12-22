//
//  ChordsService.swift
//  mwm-chords
//
//  Created by papuruu on 19/12/2021.
//

import Foundation

enum NetworkError: Error {
    case noData
    case noResponse
    case noDecoding
}

final class ChordsService {
    
    private let urlChordsService = "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords"
    private let sessionChords: URLSession
    private let sessionKeyChords: URLSession
    private var task: URLSessionTask?
    
    init(sessionChordTone: URLSession = URLSession(configuration: .default),
         sessionKeyChords: URLSession = URLSession(configuration: .default)) {
        self.sessionChords = sessionChordTone
        self.sessionKeyChords = sessionKeyChords
    }
    
    func getChordTones(callback: @escaping (Result<[String], Error>) -> Void) {
        
        guard let chordsURL = URL(string: urlChordsService) else { return }
                
        task?.cancel()
        
        task = sessionChords.dataTask(with: chordsURL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(NetworkError.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetworkError.noResponse))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Tone.self, from: data) else {
                    callback(.failure(NetworkError.noDecoding))
                    return
                }
                
                let resultNames = responseJSON.allkeys.map({ $0.name }).sorted()
                
                callback(.success(resultNames))
                print(resultNames)
            }
        })
        
        task?.resume()
    }
    
    func getKeyChords(callback: @escaping (Result<[String], Error>) -> Void) {
        
        guard let chordsURL = URL(string: urlChordsService) else { return }
                
        task?.cancel()
        
        task = sessionKeyChords.dataTask(with: chordsURL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.failure(NetworkError.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(NetworkError.noResponse))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(Tone.self, from: data) else {
                    callback(.failure(NetworkError.noDecoding))
                    return
                }
                
                let resultKeyChords = responseJSON.allchords.map({ $0.suffix }).sorted()
                callback(.success(resultKeyChords.removingDuplicates()))
            }
        })
        task?.resume()
    }
}
