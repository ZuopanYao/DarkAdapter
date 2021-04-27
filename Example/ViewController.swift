//
//  ViewController.swift
//  Example
//
//  Created by Harvey on 2021/4/22.
//

import UIKit
import DarkAdapter
import RxSwift

class ViewController: UIViewController {

    var disposeBag: DisposeBag = .init()
    lazy var isDark: Bool = {
        guard #available(iOS 13.0, *) else {
            return false
        }
        return UITraitCollection.current.userInterfaceStyle == .dark
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        view.addSubview(btn)
        btn.setTitle("dissmid", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(exit(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var btn1: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 130, width: 200, height: 50))
        view.addSubview(btn)
        btn.setTitle("push", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(doddo(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var label: UILabel = {
        let btn = UILabel(frame: CGRect(x: 0, y: 230, width: 200, height: 50))
        view.addSubview(btn)
        btn.text = "fjkgewlfkwlgjtkt"
        btn.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var iv: UIImageView = {
        let btn = UIImageView(frame: CGRect(x: 0, y: 300, width: 200, height: 200))
        view.addSubview(btn)
        return btn
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ = btn
        _ = btn1
        _ = label
        
        view.backgroundColor = .white
        view.da.backgroundColor = (.red, .blue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            btn1.isSelected = !btn1.isSelected
        }
        
//        label.da.textColor = (.systemPink, .yellow)
//        btn.da.backgroundColor = (.green, .brown)
//        btn.da.alpha = (0.8, 0.2)
//        label.da.backgroundColor = (.purple, .blue)
        btn1.da.titleColor = ((.gray, .yellow), .normal)
        btn1.da.titleColor = ((.green, .blue), .selected)
        iv.da.image = "light"
        label.da.textColor = (.systemPink, .yellow)
        btn.da.backgroundColor = (.green, .brown)
        btn.da.alpha = (0.8, 0.2)
        label.da.backgroundColor = (.purple, .blue)
        title = isDark ? "Dark" : "Light"

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        title = isDark ? "Dark" : "Light"
    }
    
    override func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }
    
    deinit {
        print("\(classForCoder) deinit")
    }
    
    @IBAction func doddo(sender:UIButton) {
        
        print("kdldkdl")
        if #available(iOS 13.0, *) {
            isDark = !isDark
            
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = isDark ? .dark : .light
        } else {
            // Fallback on earlier versions
        }
       // present(ViewController(), animated: true, completion: nil)
    }
    
    @IBAction func exit(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
