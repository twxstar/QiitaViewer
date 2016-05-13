//
//  ArticleListViewController.swift
//  QiitaViewer
//
//  Created by Tomohiro Yoshida on 2016/05/13.
//  Copyright © 2016年 Tomohiro Yoshida. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var articles: [[String: String?]] = []
    var urls: [String?] = []
    let table = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新着記事"

        // Do any additional setup after loading the view.
        table.frame = self.view.frame
        table.delegate = self
        table.dataSource = self
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(table)
        
        getArticles()
    }
    
    func getArticles() {
        Alamofire.request(.GET, "https://qiita.com/api/v2/items")
            .responseJSON(completionHandler: {(response) in
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach{(_, json) in
                    let article: [String: String?] = [
                        "title": json["title"].string,
                        "userid": json["user"]["id"].string,
                        "url"   : json["url"].string
                    ]
                    self.articles.append(article)
                }
                self.table.reloadData()
        })
    }
    
//    tableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userid"]!
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let article = articles[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.title = article["title"]!
        detailViewController.url = article["url"]!
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
