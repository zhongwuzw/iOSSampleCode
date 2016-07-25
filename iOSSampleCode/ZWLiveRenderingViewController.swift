//
//  ZWLiveRenderingViewController.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/25.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit

class ZWLiveRenderingViewController: UIViewController {

    @IBOutlet weak var watchView: ZWWatchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchView.startTimeWithTimeZone("Asia/Beijing")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
