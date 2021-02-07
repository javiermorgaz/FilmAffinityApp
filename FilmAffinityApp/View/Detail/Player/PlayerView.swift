//
//  PlayerView.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 7/2/21.
//

import SwiftUI

struct PlayerView: UIViewControllerRepresentable {
    
    let videoURL: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlayerView>) -> PlayerViewController {
        let playerViewController = PlayerViewController()
        playerViewController.loadVideoURL(videoURL: videoURL)
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: PlayerViewController, context: UIViewControllerRepresentableContext<PlayerView>) {
        
    }
}
