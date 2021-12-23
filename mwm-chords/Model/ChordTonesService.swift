//
//  ChordsService.swift
//  mwm-chords
//
//  Created by papuruu on 19/12/2021.
//

import Foundation

final class ChordTonesService {
    
    private let urlChordsService = "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords"
    private let sessionChords: URLSession
    private var task: URLSessionTask?
    
    init(sessionChordTones: URLSession = URLSession(configuration: .default)) {
        self.sessionChords = sessionChordTones
    }
    
    func getChordTones(callback: @escaping (Result<[String], Error>) -> Void) {
        
        guard let chordsURL = URL(string: urlChordsService) else { return }
        
        task?.cancel()
        
        task = sessionChords.dataTask(with: chordsURL, completionHandler: { (data, response, error) in
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
        })
        task?.resume()
    }
}
