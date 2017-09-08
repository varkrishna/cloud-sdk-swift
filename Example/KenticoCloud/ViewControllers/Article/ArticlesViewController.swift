//
//  ArticlesViewController.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import KenticoCloud
import AlamofireImage

class ArticlesViewController: UIViewController, UITableViewDataSource {
    
    private let contentType = "article"
    private var articles: [Article] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getArticles()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        cell.title.text = article.title?.value
        cell.summary.text = article.summary?.value
        
        var dateString = ""
        if let date = article.postDate?.value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateString = dateFormatter.string(from: date)
        }
        
        cell.date.text = dateString
        
        if let imageUrl = article.asset?.value?[0].url {
            let url = URL(string: imageUrl)
            cell.photo.af_setImage(withURL: url!)
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue" {
            
            let articleDetailViewController = segue.destination
                as! ArticleDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            articleDetailViewController.article = articles[indexPath.row]
            
            let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
            articleDetailViewController.image = cell.photo.image!
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    private func getArticles() {
        let cloudClient = Client.init(projectId: "adcae48f-b42b-4a53-a8fc-b3b4501561b9")
        let customQuery = "https://deliver.kenticocloud.com/adcae48f-b42b-4a53-a8fc-b3b4501561b9/items?system.type=article&order=elements.post_date[desc]"
        do {
            try cloudClient.getItems(rawUrlQuery: customQuery, modelType: Article.self) { (isSuccess, items) in
                if isSuccess {
                    if let articles = items {
                        self.articles = articles
                        self.tableView.reloadData()
                    }
                }
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

