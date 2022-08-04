//
//  ViewController.swift
//  Assignment
//
//  Created by Vasim Khan on 8/3/22.
//

import UIKit
import SafariServices
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    
    var networkHandler = NetworkHandler()
    var newsArticles: [Articles]?
    
    //TableView Cell ID
    let newsTableViewCellId = "NewsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View Cell Registered
        let nibCell = UINib(nibName: newsTableViewCellId, bundle: nil)
        newsTableView.register(nibCell, forCellReuseIdentifier: newsTableViewCellId)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        //Pull-to-Refrash
        newsTableView.refreshControl = UIRefreshControl()
        newsTableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Loader
        let loader = self.loader()
        
        //API call
        networkHandler.getNews { [self] newsData in
            newsArticles = newsData
            DispatchQueue.main.async { [self] in
                newsTableView.reloadData()
                stopLoader(loader: loader)
            }
        }
    }
    
    //Pull-to-Refresh function
    @objc func callPullToRefresh(){
        networkHandler.getNews { [self] newsData in
            newsArticles = newsData
            DispatchQueue.main.async { [self] in
                self.newsTableView.refreshControl?.endRefreshing()
                self.newsTableView.reloadData()
            }
        }
    }
    
    //Loader
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    //SF webview function
    func sfWebView(url: String) {
        guard let url = URL(string: url) else {return}
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellId, for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = newsArticles?[indexPath.row].title
        cell.descriptionLabel.text = newsArticles?[indexPath.row].description
        cell.autherLabel.text = newsArticles?[indexPath.row].author
        let url = newsArticles?[indexPath.row].urlToImage ?? ""
        cell.newsImage.kf.setImage(with: URL(string: url))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = newsArticles?[indexPath.row].url ?? ""
        sfWebView(url: url)
    }
}

extension ViewController: SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
