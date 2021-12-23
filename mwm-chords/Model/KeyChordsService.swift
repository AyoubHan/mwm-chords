//
//  KeyChordsService.swift
//  mwm-chords
//
//  Created by papuruu on 22/12/2021.
//

import Foundation

class KeyChordsService {
    
    // MARK: - Private Properties
    
    private let keyChordsURL = "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords"
    private let keyChordsSession: URLSession
    private var task: URLSessionTask?
    
    init(keyChordsSession: URLSession = URLSession(configuration: .default)) {
        self.keyChordsSession = keyChordsSession
    }
    
    // MARK: - getKeyChords request
    
    func getKeyChords(callback: @escaping (Result<[String], Error>) -> Void) {
        
        guard let chordsURL = URL(string: keyChordsURL) else { return }
        
        task?.cancel()
        
        task = keyChordsSession.dataTask(with: chordsURL, completionHandler: { (data, response, error) in
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
                
                var resultKeyChords = responseJSON.allchords.map({ $0.suffix }).sorted()
                callback(.success(resultKeyChords.removeDuplicates()))
            }
        })
        task?.resume()
    }
}
