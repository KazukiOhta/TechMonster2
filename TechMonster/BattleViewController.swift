//
//  BattleViewController.swift
//  TechMonster
//
//  Created by 太田 一毅 on 2019/03/29.
//  Copyright © 2019 太田 一毅. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    var enemy: Enemy!
    var player: Player!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    var enemyAttackTimer: Timer!
    
    var TechDraUtil: TechDraUtility = TechDraUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enemyHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)

        playerNameLabel.text = player.name
        playerImageView.image = player.image
        playerHPBar.progress = player.currentHP / player.maxHP
        enemyHPBar.progress = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startBattle()
    }

    func startBattle(){
        TechDraUtil.playBGM(fileName: "BGM_battle001")
        
        player = Player()
        enemy = Enemy()
        
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        
        attackButton.isHidden = false
        
        enemyAttackTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0/enemy.speed), target: self, selector: #selector(self.enemyAttack), userInfo: nil, repeats: true)
    }
    
    @IBAction func playerAttack(){
        TechDraUtil.damageAnimation(imageView: enemyImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        
        enemy.currentHP -= player.attackPoint
        enemyHPBar.setProgress(enemy.currentHP/enemy.maxHP, animated: true)
        
        if enemy.currentHP <= 0{
            TechDraUtil.vanishAnimation(imageView: enemyImageView)
            finishBattle(winPlayer: true)
        }
    }
    
    @objc func enemyAttack(){
        TechDraUtil.damageAnimation(imageView: playerImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        
        player.currentHP -= enemy.attackPoint
        playerHPBar.setProgress(player.currentHP/player.maxHP, animated: true)
        
        if player.currentHP <= 0{
            TechDraUtil.vanishAnimation(imageView: playerImageView)
            finishBattle(winPlayer: false)
        }
    }
    
    func finishBattle(winPlayer: Bool){
        TechDraUtil.stopBGM()
        enemyAttackTimer.invalidate()
        
        attackButton.isHidden = true
        let finishedMessage: String
        if winPlayer == true{
            TechDraUtil.playSE(fileName: "SE_fanfare")
            finishedMessage = "プレイヤーの勝利！！"
        } else {
            TechDraUtil.playSE(fileName: "SE_gameover")
            finishedMessage = "プレイヤーの敗北..."
        }
        let alert = UIAlertController(title: "バトル終了！！", message: finishedMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
