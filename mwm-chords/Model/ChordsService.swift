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
    
    private let sessionChordTones: URLSession
    private let sessionKeyChords: URLSession
    private var task: URLSessionTask?
    
    init(sessionChordTone: URLSession = URLSession(configuration: .default),
         sessionKeyChords: URLSession = URLSession(configuration: .default)) {
        self.sessionChordTones = sessionChordTone
        self.sessionKeyChords = sessionKeyChords
    }
    
    func getChordTones(callback: @escaping (Result<[String], Error>) -> Void) {
        
        guard let chordsURL = URL(string: "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords") else { return }
                
        task?.cancel()
        
        task = sessionChordTones.dataTask(with: chordsURL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("something went wrong")
                    callback(.failure(NetworkError.noData))
                    return
                }
                
                print("odk")
                print(data)
                
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
}
