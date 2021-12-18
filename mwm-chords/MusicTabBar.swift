//
//  MusicTabBar.swift
//  mwm-chords
//
//  Created by papuruu on 18/12/2021.
//

import UIKit

class MusicTabBar: UITabBarController {

    // MARK: - Private Properties
    
    private let tunerVC = TunerViewController()
    private let chromaticVC = ChromaticViewController()
    private let chordsVC = ChordsViewController()
    private let metronomeVC = MetronomeViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    // MARK: - Private Methods
    
    private func setTabBar() {
        let controllers = [tunerVC, chromaticVC, chordsVC, metronomeVC]
        
        setTabBarItems()
    
        self.setViewControllers(controllers, animated: false)
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .darkGray
    }
    
    private func setTabBarItems() {
        tunerVC.tabBarItem.image = UIImage(systemName: "tuningfork")
        chromaticVC.tabBarItem.image = UIImage(systemName: "waveform.path")
        chordsVC.tabBarItem.image = UIImage(systemName: "music.note")
        metronomeVC.tabBarItem.image = UIImage(systemName: "metronome.fill")
    }
    
}


