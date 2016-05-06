//
//  ViewController.swift
//  SmartFoodDeliverySeller
//
//  Created by Yan Lu on 16/5/6.
//  Copyright © 2016年 Yan Lu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    var orderID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        OrderInfoLabel.text="No order Yet"
//        upDateView("ds", uuid: "asdf")
    }
    @IBOutlet weak var OrderInfoLabel: UILabel!
    func upDateView(order:String,uuid:String){
        print(order)
        orderID=order
//        OrderInfoLabel.text=order
//        var th1=NSThread(target:self,selector:"fun1",object:nil)
//th1.start()
        

//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            //code here
//            print("hehe")
//            self.OrderInfoLabel.text="go"
//        })
        
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
            "http://128.59.46.47:5000/delivery")!); request.HTTPMethod = "POST"
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
//    func fun1(){
//        OrderInfoLabel.text="go"
//        print("jhe")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

