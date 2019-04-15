//
//  ViewController.swift
//  arceliksupurge
//
//  Created by Gökhan Mandacı on 15.04.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {

    // MARK: Parameters
    let mainViewLeftValue: CGFloat = 56
    let headerTopHidden: CGFloat = -200
    let headerTopVisible: CGFloat = 15
    let soundButtonsCommonStartingValue: CGFloat = 400
    let dbaArr = [92, 92, 84, 82, 91]
    
    // Players
    var playerOne: AVAudioPlayer?
    var playerTwo: AVAudioPlayer?
    
    // MARK: Outlets
    // Main View
    @IBOutlet weak var vwMainLeft: UIView!
    @IBOutlet weak var imgMainRight: UIImageView!
    @IBOutlet weak var btnTry: UIButton!
    @IBOutlet weak var vwMainLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgMainTrailingConstraint: NSLayoutConstraint!
    // Header View
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var btnBackTopConstraint: NSLayoutConstraint!
    // Sounds
    @IBOutlet weak var vwSounds: UIView!
    @IBOutlet weak var vwSpeaking: UIView!
    @IBOutlet weak var imgSoundSpeaking: UIImageView!
    @IBOutlet weak var vwBirds: UIView!
    @IBOutlet weak var imgSoundBirds: UIImageView!
    @IBOutlet weak var vwMusic: UIView!
    @IBOutlet weak var imgSoundMusic: UIImageView!
    @IBOutlet weak var vwBaby: UIView!
    @IBOutlet weak var imgSoundBaby: UIImageView!
    @IBOutlet weak var vwVacuum: UIView!
    @IBOutlet weak var imgSoundVacuum: UIImageView!
    @IBOutlet weak var vwSpakingConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwBirdsConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwMusicConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwBabyConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwVacuumConstraint: NSLayoutConstraint!
    // Info Views
    @IBOutlet weak var vwLeftInfo: UIView!
    @IBOutlet weak var vwRightInfo: UIView!
    @IBOutlet weak var vwLeftInfoConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwRightInfoConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblLeftTitle: UILabel!
    @IBOutlet weak var lblLeftInfo: UILabel!
    @IBOutlet weak var lblLeftDba: UILabel!
    @IBOutlet weak var lblLeftAverageDba: UILabel!
    
    // MARK: Actions
    @IBAction func btnTryAction(_ sender: Any) {
        startingAnimations()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        guard let playerOne = playerOne else { return }
        playerOne.stop()
        guard let playerTwo = playerTwo else { return }
        playerTwo.stop()
        backAnimations()
    }
    @IBAction func btnLeftAudioAction(_ sender: UIButton) {
        startAudioAnimation(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
    }
    
}

// Class functions
extension MainVC {
    private func setUI() {
        lblLeftTitle.setLetterSpacing(0.79)
        lblLeftInfo.setLetterSpacing(0.82)
        lblLeftDba.setLetterSpacing(0.53)
        lblLeftAverageDba.setLetterSpacing(0.41)
    }
    
    private func startingAnimations() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwMainLeadingConstraint.constant = -self.view.bounds.width
            self.imgMainTrailingConstraint.constant = self.view.bounds.width
            self.btnBackTopConstraint.constant = self.headerTopVisible
            self.view.layoutIfNeeded()
        }) { (isFin) in
            self.btnAnimations()
        }
        vwSounds.isHidden = false
        clearButtons()
    }
    
    private func backAnimations() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwMainLeadingConstraint.constant = self.mainViewLeftValue
            self.imgMainTrailingConstraint.constant = 0
            self.btnBackTopConstraint.constant = self.headerTopHidden
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        vwSpakingConstraint.constant = soundButtonsCommonStartingValue
        vwBirdsConstraint.constant = soundButtonsCommonStartingValue
        vwMusicConstraint.constant = soundButtonsCommonStartingValue
        vwBabyConstraint.constant = -soundButtonsCommonStartingValue
        vwVacuumConstraint.constant = -soundButtonsCommonStartingValue
        vwSounds.isHidden = true
        vwLeftInfo.alpha = 0
        vwRightInfo.alpha = 0
        btnTitle.setTitle("Sesini Seç", for: .normal)
        vwLeftInfoConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    private func btnAnimations() {
        UIView.animate(withDuration: 0.44, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwSpakingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            print(isFin)
        }
        UIView.animate(withDuration: 0.44, delay: 0.1, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwBirdsConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            print(isFin)
        }
        UIView.animate(withDuration: 0.44, delay: 0.1, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwMusicConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            print(isFin)
        }
        UIView.animate(withDuration: 0.44, delay: 0.44, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwBabyConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            print(isFin)
        }
        UIView.animate(withDuration: 0.44, delay: 0.54, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwVacuumConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    private func startAudioAnimation(_ btn: UIButton) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwLeftInfoConstraint.constant = 83
            self.vwLeftInfo.alpha = 1.0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        setButtons(btn)
        btnTitle.setTitle("Sessizliği Deneyimliyorsun", for: .normal)
    }
    
    private func setButtons(_ btn: UIButton) {
        clearButtons()
        switch btn.tag {
        case 1:
            vwSpeaking.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundSpeaking.isHidden = false
            lblLeftAverageDba.text = "Ortalama Değer \(dbaArr[0]) dBA"
            guard let url = Bundle.main.url(forResource: "speaking", withExtension: "mp3") else { return }
            playSound(url: url)
        case 2:
            vwBirds.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundBirds.isHidden = false
            lblLeftAverageDba.text = "Ortalama Değer \(dbaArr[1]) dBA"
            guard let url = Bundle.main.url(forResource: "birds", withExtension: "mp3") else { return }
            playSound(url: url)
        case 3:
            vwMusic.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundMusic.isHidden = false
            lblLeftAverageDba.text = "Ortalama Değer \(dbaArr[2]) dBA"
            guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }
            playSilentVacuum()
            playSound(url: url)
        case 4:
            vwBaby.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundBaby.isHidden = false
            lblLeftAverageDba.text = "Ortalama Değer \(dbaArr[3]) dBA"
            guard let url = Bundle.main.url(forResource: "baby", withExtension: "mp3") else { return }
            playSound(url: url)
        case 5:
            vwVacuum.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundVacuum.isHidden = false
            lblLeftAverageDba.text = "Ortalama Değer \(dbaArr[4]) dBA"
            guard let url = Bundle.main.url(forResource: "normalvacuum", withExtension: "mp4") else { return }
            playSound(url: url)
        default:
            print("Unknown tag")
        }
    }
    
    private func endAudioAnimation() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwLeftInfoConstraint.constant = 0
            self.vwLeftInfo.alpha = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        clearButtons()
    }
    
    private func clearButtons() {
        btnTitle.setTitle("Sesini Seç", for: .normal)
        vwSpeaking.backgroundColor = .clear
        vwBirds.backgroundColor = .clear
        vwMusic.backgroundColor = .clear
        vwBaby.backgroundColor = .clear
        vwVacuum.backgroundColor = .clear
        imgSoundSpeaking.isHidden = true
        imgSoundBirds.isHidden = true
        imgSoundMusic.isHidden = true
        imgSoundBaby.isHidden = true
        imgSoundVacuum.isHidden = true
    }
}

// Players
extension MainVC {
    private func playSound(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            playerOne = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = playerOne else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func playSilentVacuum() {
        guard let url = Bundle.main.url(forResource: "vacuum", withExtension: "mp4") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            playerTwo = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = playerTwo else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
