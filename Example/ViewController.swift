//
//  ViewController.swift
//  Example
//
//  Created by Harvey on 2021/4/22.
//

import UIKit
import DarkMode
import RxSwift

class ViewController: UIViewController {

    var disposeBag: DisposeBag = .init()
    
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
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _ = btn
        _ = btn1
        
        view.backgroundColor = .white
        view.dm.backgroundColor = (.red, .blue)
    }
    
    override func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }
    
    deinit {
        print("\(classForCoder) deinit")
    }
    
    @IBAction func doddo(sender:UIButton) {
        present(ViewController(), animated: true, completion: nil)
    }
    
    @IBAction func exit(sender:UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

