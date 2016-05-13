//
//  DetailViewController.swift
//  QiitaViewer
//
//  Created by Tomohiro Yoshida on 2016/05/13.
//  Copyright © 2016年 Tomohiro Yoshida. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate{
    let webView = WKWebView()
    let alViewController = ArticleListViewController()
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView.frame = self.view.frame
        self.view.addSubview(webView)
        
        loadURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadURL() {
        guard let myUrl = NSURL(string: url!) else {
            return
        }
        let req = NSURLRequest(URL: myUrl)
        webView.loadRequest(req)
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
