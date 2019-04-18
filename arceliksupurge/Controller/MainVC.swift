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
    let dbaTitleArr = ["Ev İçinde Sohbet", "Kuş Sesi", "Müzik Kutusu", "Bebek Gülüşü", "Standart Süpürge"]
    let dbaArr = [84, 92, 82, 91, 74]
    var willStop: Bool = false
    var playinTag: Int = 0
    let gifURL : String = "https://media.giphy.com/media/QrooGoDTEGK52/giphy.gif"
    
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
    @IBOutlet weak var vwLeftEq: EqView!
    @IBOutlet weak var imgRightEq: UIImageView!
    @IBOutlet weak var imgLeftEq: UIImageView!
    // Vacuum Player
    @IBOutlet weak var vwPlayer: UIView!
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var btnPlayer: UIButton!
    @IBOutlet weak var vwPlayerConstraint: NSLayoutConstraint!
    
    // MARK: Actions
    @IBAction func btnTryAction(_ sender: Any) {
        startingAnimations()
    }
    @IBAction func btnBackAction(_ sender: Any) {
        backAnimations()
        playinTag = 0
        if let playerOne = playerOne {
            playerOne.stop()
        }
        if let playerTwo = playerTwo {
            if playerTwo.isPlaying {
                animatePlayerButton()
            }
            playerTwo.stop()
        }
    }
    @IBAction func btnLeftAudioAction(_ sender: UIButton) {
        startAudioAnimation(sender)
    }
    @IBAction func btnPlayerAction(_ sender: Any) {
        animatePlayerButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageDataLeft = try? Data(contentsOf: Bundle.main.url(forResource: "eq_imperium", withExtension: "gif")!)
        imgLeftEq.image = UIImage.gifImageWithData(imageDataLeft!)
        let imageDataRight = try? Data(contentsOf: Bundle.main.url(forResource: "eq_other", withExtension: "gif")!)
        imgRightEq.image = UIImage.gifImageWithData(imageDataRight!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            self.vwPlayerConstraint.constant = self.soundButtonsCommonStartingValue
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
        UIView.animate(withDuration: 0.38) {
            self.vwPlayerConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
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
        UIView.animate(withDuration: 0.44, delay: 0.25, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.vwBabyConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            print(isFin)
        }
        UIView.animate(withDuration: 0.44, delay: 0.35, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
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
        setButtonPressAnimation(btn)
        if let playerOne = playerOne, playerOne.isPlaying && playinTag == btn.tag {
            endAudioAnimation()
            clearButtons()
            playerOne.stop()
            btnTitle.setTitle("Sesini Seç", for: .normal)
        } else {
            playinTag = btn.tag
            setButtons(btn)
            btnTitle.setTitle("Sessizliği Deneyimliyorsun", for: .normal)
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
    
    private func startSilentAnimation() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwRightInfoConstraint.constant = 83
            self.vwRightInfo.alpha = 1.0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    private func endSilentAnimation() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.44, animations: {
            self.vwRightInfoConstraint.constant = 0
            self.vwRightInfo.alpha = 0
            self.view.layoutIfNeeded()
        }) { (isFin) in
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    private func setButtons(_ btn: UIButton) {
        clearButtons()
        switch btn.tag {
        case 1:
            vwSpeaking.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundSpeaking.isHidden = false
            lblLeftInfo.text = dbaTitleArr[0]
            lblLeftDba.text = "\(dbaArr[0]) Desibel [dBA] ortalama"
            guard let url = Bundle.main.url(forResource: "speaking", withExtension: "mp3") else { return }
            playSound(url: url)
        case 2:
            vwBirds.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundBirds.isHidden = false
            lblLeftInfo.text = dbaTitleArr[1]
            lblLeftDba.text = "\(dbaArr[1]) Desibel [dBA] ortalama"
            guard let url = Bundle.main.url(forResource: "birds", withExtension: "mp3") else { return }
            playSound(url: url)
        case 3:
            vwMusic.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundMusic.isHidden = false
            lblLeftInfo.text = dbaTitleArr[2]
            lblLeftDba.text = "\(dbaArr[2]) Desibel [dBA] ortalama"
            guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }
            playSound(url: url)
        case 4:
            vwBaby.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundBaby.isHidden = false
            lblLeftInfo.text = dbaTitleArr[3]
            lblLeftDba.text = "\(dbaArr[3]) Desibel [dBA] ortalama"
            guard let url = Bundle.main.url(forResource: "baby", withExtension: "mp3") else { return }
            playSound(url: url)
        case 5:
            vwVacuum.backgroundColor = UIColor(displayP3Red: 191/255, green: 45/255, blue: 57/255, alpha: 1.0)
            imgSoundVacuum.isHidden = false
            lblLeftInfo.text = dbaTitleArr[4]
            lblLeftDba.text = "\(dbaArr[4]) Desibel [dBA] ortalama"
            guard let url = Bundle.main.url(forResource: "normalvacuum", withExtension: "mp4") else { return }
            playSound(url: url)
        default:
            print("Unknown tag")
        }
    }
    
    private func setButtonPressAnimation(_ button: UIButton) {
        var aView: UIView?
        switch button.tag {
        case 1:
            aView = vwSpeaking
        case 2:
            aView = vwBirds
        case 3:
            aView = vwMusic
        case 4:
            aView = vwBaby
        case 5:
            aView = vwVacuum
        default:
            print("Unknown tag")
        }
        guard let vw = aView else { return }
        UIView.animate(withDuration: 0.1, animations: {
            vw.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (isFin) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                vw.transform = CGAffineTransform.identity
            })
        }
    }
    
    private func clearButtons() {
        btnTitle.setTitle("Sesini Seç", for: .normal)
        vwSpeaking.backgroundColor = .clear
        vwBirds.backgroundColor = .clear
        vwMusic.backgroundColor = .clear
        vwBaby.backgroundColor = .clear
        vwVacuum.backgroundColor = .clear
        vwSpeaking.layer.borderColor = UIColor(displayP3Red: 76/255, green: 56/255, blue: 86/255, alpha: 1.0).cgColor
        vwSpeaking.layer.borderWidth = 1
        vwBirds.layer.borderColor = UIColor(displayP3Red: 76/255, green: 56/255, blue: 86/255, alpha: 1.0).cgColor
        vwBirds.layer.borderWidth = 1
        vwMusic.layer.borderColor = UIColor(displayP3Red: 76/255, green: 56/255, blue: 86/255, alpha: 1.0).cgColor
        vwMusic.layer.borderWidth = 1
        vwBaby.layer.borderColor = UIColor(displayP3Red: 76/255, green: 56/255, blue: 86/255, alpha: 1.0).cgColor
        vwBaby.layer.borderWidth = 1
        vwVacuum.layer.borderColor = UIColor(displayP3Red: 76/255, green: 56/255, blue: 86/255, alpha: 1.0).cgColor
        vwVacuum.layer.borderWidth = 1
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
            player.delegate = self
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
            player.delegate = self
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// Player View Functions
extension MainVC {
    private func animatePlayerImage() {
        willStop = false
        piAnimation(true)
    }
    
    private func stopPlayerImage() {
        willStop = true
        piAnimation(false)
    }
    
    private func piAnimation(_ fadein: Bool) {
        if willStop {
            self.imgPlayer.alpha = 0
            return
        }
        var value: CGFloat = 0
        if fadein { value = 1 } else { value = 0.15 }
        UIView.animate(withDuration: 0.7, animations: {
            self.imgPlayer.alpha = value
        }) { (isFin) in
            self.piAnimation(!fadein)
        }
    }
    
    private func animatePlayerButton() {
        if let playerTwo = playerTwo, playerTwo.isPlaying {
            playerTwo.stop()
            stopPlayerImage()
            endSilentAnimation()
            btnPlayer.setImage(UIImage(named: "notpressed"), for: .normal)
        } else {
            startSilentAnimation()
            UIView.animate(withDuration: 0.1, animations: {
                self.btnPlayer.setImage(UIImage(named: "pressed"), for: .normal)
                self.btnPlayer.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            }) { (isFin) in
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.btnPlayer.transform = CGAffineTransform.identity
                }) { (isFin) in
                    self.animatePlayerImage()
                    self.playSilentVacuum()
                }
            }
        }
    }
}

extension MainVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            player.play()
        }
    }
}
