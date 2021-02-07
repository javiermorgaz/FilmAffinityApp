//
//  PlayerViewController.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 7/2/21.
//

import UIKit
import SafariServices
import DailymotionPlayerSDK

class PlayerViewController: UIViewController {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet fileprivate var playerHeightConstraint: NSLayoutConstraint! {
        didSet {
            initialPlayerHeight = playerHeightConstraint.constant
        }
    }
    fileprivate var initialPlayerHeight: CGFloat!
    fileprivate var isPlayerFullscreen = false
    fileprivate var videoURL: String = ""
    
    fileprivate lazy var playerViewController: DMPlayerViewController = {
        let parameters: [String: Any] = [
            "fullscreen-action": "trigger_event",
            "sharing-action": "trigger_event"
        ]
        
        let controller = DMPlayerViewController(parameters: parameters, allowPiP: false)
        controller.delegate = self
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerViewController()
    }
    
    func loadVideoURL(videoURL: String) {
        self.videoURL = videoURL
    }
    
    private func setupPlayerViewController() {
        addChild(playerViewController)
        
        let view = playerViewController.view!
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isPlayerFullscreen = size.width > size.height
        playerViewController.toggleFullscreen()
        updatePlayer(height: size.height)
    }
    
    @IBAction private func play(_ sender: Any) {
        guard let videoId = findVideoId() else { return }
        playerViewController.load(videoId: videoId)
    }
    
    
    private func findVideoId() -> String? {
        let strRegExp = "\\/video\\/([^_]+)\\?"
        let range = NSRange(location: 0, length: videoURL.utf16.count)
        let regex = try! NSRegularExpression(pattern: strRegExp)
        
        let result = regex.firstMatch(in: videoURL, options: [], range: range)
        
        return result.map {
            String(videoURL[Range($0.range, in: videoURL)!])
        }

    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension PlayerViewController: DMPlayerViewControllerDelegate {
    
    func player(_ player: DMPlayerViewController, didReceiveEvent event: PlayerEvent) {
        switch event {
        case .namedEvent(let name, _) where name == "fullscreen_toggle_requested":
            toggleFullScreen()
        case .namedEvent(let name, .some(let data)) where name == "share_requested":
            guard let raw = data["shortUrl"] ?? data["url"], let url = URL(string: raw) else { return }
            share(url: url)
        default:
            break
        }
    }
    
    fileprivate func toggleFullScreen() {
        isPlayerFullscreen = !isPlayerFullscreen
        updateDeviceOrientation()
        updatePlayer(height: view.frame.size.height)
    }
    
    private func updateDeviceOrientation() {
        let orientation: UIDeviceOrientation = isPlayerFullscreen ? .landscapeLeft : .portrait
        UIDevice.current.setValue(orientation.rawValue, forKey: #keyPath(UIDevice.orientation))
    }
    
    fileprivate func updatePlayer(height: CGFloat) {
        if isPlayerFullscreen {
            playerHeightConstraint.constant = height
        } else {
            playerHeightConstraint.constant = initialPlayerHeight
        }
    }
    
    private func share(url: URL) {
        playerViewController.pause()
        let item = ShareActivityItemProvider(title: "Dailymotion", url: url)
        let shareViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        shareViewController.excludedActivityTypes = [.assignToContact, .print]
        present(shareViewController, animated: true, completion: nil)
    }
    
    func player(_ player: DMPlayerViewController, openUrl url: URL) {
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true, completion: nil)
    }
    
    func playerDidInitialize(_ player: DMPlayerViewController) {
    }
    
    func player(_ player: DMPlayerViewController, didFailToInitializeWithError error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}
