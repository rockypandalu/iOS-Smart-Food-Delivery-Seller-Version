//
//  ViewController.swift
//  SmartFoodDeliverySeller
//
//  Created by Yan Lu on 16/5/6.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var QRImageView: UIImageView!
    
    var orderID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add Notification Receiver
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UpdateOrder:", name: "OrderChangedNotification", object: nil)

    }
    @IBOutlet weak var OrderInfoLabel: UILabel!

    func UpdateOrder(notification: NSNotification) {
        //deal with notification.userInfo
        let dictOrder = notification.userInfo as? NSDictionary
        if let order = dictOrder!["order"] as? String{
            OrderInfoLabel.text=order
        }
        if let uid = dictOrder!["uid"] as? String{
            QRImageView.image={
                var qrCode=QRCode(uid)
                qrCode?.color=CIColor(rgba: "5a44ad")
                return qrCode!.image
                }()
        }
        
        
    }

    @IBAction func PickUpAction(sender: AnyObject) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let deviceToken = delegate.uid
        if (deviceToken==nil){
            let alertController = UIAlertController(title: "Order Incorrect!", message:
                "You have no order to deliver to this location", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            httpPost(deviceToken!)
            print("done")
        }
    }
    func httpPost(postString: String){
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://129.236.230.130:5000/deliver")!); request.HTTPMethod = "POST"
        //Show the message sent to PI on IOS device
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        print(request.HTTPBody)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in if error != nil {
                print("error=\(error)")
                return}
            print("response = \(response)")
            let responseString = NSString(data: data!, encoding:
                NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

