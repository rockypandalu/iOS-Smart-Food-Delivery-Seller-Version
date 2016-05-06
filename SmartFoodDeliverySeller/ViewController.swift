//
//  ViewController.swift
//  SmartFoodDeliverySeller
//
//  Created by Yan Lu on 16/5/6.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    var uid:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        OrderInfoLabel.text="No order Yet"
    }
    func upDateView(){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        uid = delegate.uid
        let order = delegate.order
        print(order)
//        OrderInfoLabel.text="g"
        //        OrderInfoLabel.text = String(order!)
        //        QRImageView.image={
        //            var qrCode=QRCode(uid!)
        //            qrCode?.color=CIColor(rgba: "5a44ad")
        //            //qrCode?.backgroundColor = CIColor(rgba: "000")
        //            return qrCode!.image
        //            }()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

