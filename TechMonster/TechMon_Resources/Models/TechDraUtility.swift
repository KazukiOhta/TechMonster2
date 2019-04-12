//
//  TechDraUtility.swift
//  TechDra
//
//  Created by Master on 2015/03/23.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit
import AVFoundation

class TechDraUtility: NSObject, AVAudioPlayerDelegate {
    
    var BGM_audioPlayer: AVAudioPlayer!
    var SE_audioPlayer: AVAudioPlayer!
    
    override init() {
        super.init()
        
        BGM_audioPlayer = AVAudioPlayer()
    }
    
    //MARK: Animations
    // !! class func damageAnimation(imageView: UIImageView) {
    func damageAnimation(imageView: UIImageView) {

        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.02
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:imageView.center.x - 5, y:imageView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x:imageView.center.x + 5, y:imageView.center.y))
        imageView.layer.add(animation, forKey: "position")
        
    }
    
    // !!class func vanishAnimation(imageView: UIImageView) {
    func vanishAnimation(imageView: UIImageView) {

        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            imageView.alpha = 0.0
        }, completion: nil)
    }
    
    //MARK: Sound Effects
    func playSE(fileName: String) {
        
        //AVAudioPlayer
        let soundFilePath: String = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let fileURL: URL = URL(fileURLWithPath: soundFilePath)

        do {
            SE_audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        }catch {
            print("ファイルを読み込めませんでした。")
        }
        
        SE_audioPlayer.prepareToPlay()
        if SE_audioPlayer.isPlaying == true {
            SE_audioPlayer.currentTime = 0
        }
        SE_audioPlayer.play()
    }
    
    func playBGM(fileName: String) {
        
        let soundFilePath : String = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let fileURL : URL = URL(fileURLWithPath: soundFilePath)

        do {
            BGM_audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("ファイルを読み込めませんでした。")
        }
        BGM_audioPlayer.numberOfLoops = -1
        BGM_audioPlayer.delegate = self
        BGM_audioPlayer.prepareToPlay()
        if BGM_audioPlayer.isPlaying == true {
            BGM_audioPlayer.currentTime = 0
        }
        
        BGM_audioPlayer.play()
    }
    
    func stopBGM() {
        BGM_audioPlayer.stop()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            
        }
    }
}
