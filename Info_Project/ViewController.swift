//
//  ViewController.swift
//  Info_Project
//
//  Created by Pallavi Kowale on 14/12/19.
//  Copyright © 2019 Pallavi Kowale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var tableToDisplay : UITableView?
    var webArr : [[String : Any]] = [[String : Any]]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDisplayTable()
        parseData()
    }
    
     func parseData() {
        
        
        let session = URLSession.shared
        var webUrl = "https://api.github.com/users/hadley/orgs"
        ////webUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        let url = URL(string: webUrl)!
        
       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
                    guard let mime = response.mimeType, mime == "application/json" else {
                        print("Wrong MIME type!")
                        return
                    }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print("json data \(json)")
                

                
                self.webArr = json as! [[String: Any]]
                
                DispatchQueue.main.async {
                    self.tableToDisplay?.reloadData()

                }
                

                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
    }
    
    
    func setupDisplayTable() {
        
        tableToDisplay = UITableView()
        tableToDisplay?.backgroundColor = UIColor.white
        tableToDisplay?.delegate = self
        tableToDisplay?.dataSource = self
        tableToDisplay?.separatorStyle = .none
        tableToDisplay?.estimatedRowHeight = 170
        tableToDisplay?.rowHeight = UITableView.automaticDimension
        //tableToDisplay?.rowHeight = 170
        tableToDisplay?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableToDisplay?.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        self.view.addSubview(tableToDisplay!)
        
        
        tableToDisplay?.enableAutolayout()
        tableToDisplay?.leadingMargin(pixel: 10)
        tableToDisplay?.trailingMargin(pixel: 10)
        tableToDisplay?.topMargin(pixel: 10)
        tableToDisplay?.bottomMargin(pixel: 10)
    }
    
    //MARK: - UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        if (self.webArr.count > 0)
        {
            let cellData = self.webArr[indexPath.row]
            
            cell.titleLabel?.text = cellData["login"] as! String
            cell.subtitleLabel?.text = cellData["node_id"] as! String
            
            let imgUrl = cellData["avatar_url"] as! String
            cell.displayImg?.downloaded(from: imgUrl, contentMode: .scaleAspectFit)
        }
 
        return cell
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

