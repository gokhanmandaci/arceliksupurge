//
//  EqView.swift
//  arceliksupurge
//
//  Created by Gökhan Mandacı on 16.04.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

class EqView: UIView {

    // MARK: Parameters
    var colorTop = UIColor(displayP3Red: 41/255, green: 124/255, blue: 117/255, alpha: 1.0)
    var colorMid = UIColor(displayP3Red: 41/255, green: 57/255, blue: 124/255, alpha: 1.0)
    var colorBottomTop = UIColor(displayP3Red: 116/255, green: 44/255, blue: 116/255, alpha: 1.0)
    var colorBottom = UIColor(displayP3Red: 116/255, green: 44/255, blue: 80/255, alpha: 1.0)
    
    // MARK: Outlets
    @IBOutlet weak var col1: UIView!
    @IBOutlet weak var col2: UIView!
    @IBOutlet weak var col3: UIView!
    @IBOutlet weak var col4: UIView!
    @IBOutlet weak var col5: UIView!
    @IBOutlet weak var col6: UIView!
    
    // MARK: Actions
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - setup
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        
        //setCol1(col: col1, multiplier: 0)
        
        addSubview(view)
        //animate()
    }
    
    /// Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

extension EqView {
    private func setCol1(col: UIView, multiplier: Int) {
        let width = col1.frame.width
        let height = width * 0.4375
        for index in 0...5 {
            switch index {
            case 0:
                let item = UIView(frame: CGRect(x: 0, y: 70, width: width, height: height))
                item.backgroundColor = colorBottom
                item.tag = multiplier + 0
                col.addSubview(item)
            case 1:
                let item = UIView(frame: CGRect(x: 0, y: 56, width: width, height: height))
                item.backgroundColor = colorBottom
                item.tag = multiplier + 1
                col.addSubview(item)
            case 2:
                let item = UIView(frame: CGRect(x: 0, y: 42, width: width, height: height))
                item.backgroundColor = colorBottomTop
                item.tag = multiplier + 2
                col.addSubview(item)
            case 3:
                let item = UIView(frame: CGRect(x: 0, y: 28, width: width, height: height))
                item.backgroundColor = colorMid
                item.tag = multiplier + 3
                col.addSubview(item)
            case 4:
                let item = UIView(frame: CGRect(x: 0, y: 14, width: width, height: height))
                item.backgroundColor = colorMid
                item.tag = multiplier + 4
                col.addSubview(item)
            case 5:
                let item = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
                item.backgroundColor = colorTop
                item.tag = multiplier + 5
                col.addSubview(item)
            default:
                print("Unknown index")
            }
        }
        switch col {
        case col1:
            setCol1(col: col2, multiplier: 6)
        case col2:
            setCol1(col: col3, multiplier: 12)
        case col3:
            setCol1(col: col4, multiplier: 18)
        case col4:
            setCol1(col: col5, multiplier: 24)
        case col5:
            setCol1(col: col6, multiplier: 30)
        case col6:
            break
        default:
            print("Unknown col")
        }
    }
    
    func animate() {
        let rnd1 = Int(arc4random_uniform(3) + 3)
        let rnd2 = Int(arc4random_uniform(3) + 3)
        let rnd3 = Int(arc4random_uniform(3) + 3)
        let rnd4 = Int(arc4random_uniform(3) + 3)
        let rnd5 = Int(arc4random_uniform(3) + 3)
        let rnd6 = Int(arc4random_uniform(3) + 3)
        _ = [UIView]()
        for indx in rnd1...5 {
            let view = col1.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        //self.animate()
                    }
                })
            }
        }
        for indx in rnd2...5 {
            let view = col2.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        //self.animate()
                    }
                })
            }
        }
        for indx in rnd3...5 {
            let view = col3.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        //self.animate()
                    }
                })
            }
        }
        for indx in rnd4...5 {
            let view = col4.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        //self.animate()
                    }
                })
            }
        }
        for indx in rnd5...5 {
            let view = col5.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        //self.animate()
                    }
                })
            }
        }
        for indx in rnd6...5 {
            let view = col6.subviews[indx]
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (isFin) in
                UIView.animate(withDuration: 0.3, animations: {
                    view.alpha = 1.0
                }, completion: { (isFin) in
                    if indx == 5 {
                        self.animate()
                    }
                })
            }
        }
    }
}
