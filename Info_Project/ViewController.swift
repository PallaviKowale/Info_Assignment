//
//  ViewController.swift
//  Info_Project
//
//  Created by Pallavi Kowale on 14/12/19.
//  Copyright © 2019 Pallavi Kowale. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkOperationDelegate {
   
    var activityIndicatorObj : UIActivityIndicatorView?
    var tableToDisplay : UITableView?
    var errorLabel : UILabel?
    
    var webArr : [[String : Any]] = [[String : Any]]()
    
    let networkObj : NetworkOperationUtil = NetworkOperationUtil()
    let cellConst : String = "CustomTableViewCell"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        networkObj.delegate = self
        networkObj.parseData()
    }
    
    func dataRecieved(response: AnyObject?) {
        if response != nil
        {
            self.webArr = response as! [[String: Any]]
            self.tableToDisplay?.reloadData()
        }
        else
        {
            self.errorLabel?.text = "No Data found"
            self.errorLabel?.isHidden = false
        }
        
    }
    
    
    func setupUI() {
        
        let constPadding : CGFloat = 10
        let estimatedRowHeight : CGFloat = 170
        let leftRightPadding : CGFloat = 0
        
        let activityWidthHeight : CGFloat = 80
        let errorLblWidth : CGFloat = 150
        let errorLblHeight : CGFloat = 30
        
        //1. Add Tableview
        tableToDisplay = UITableView()
        tableToDisplay?.backgroundColor = UIColor.white
        tableToDisplay?.delegate = self
        tableToDisplay?.dataSource = self
        tableToDisplay?.separatorStyle = .none
        tableToDisplay?.estimatedRowHeight = estimatedRowHeight
        tableToDisplay?.rowHeight = UITableView.automaticDimension
        tableToDisplay?.contentInset = UIEdgeInsets(top: constPadding,
                                                    left: leftRightPadding,
                                                    bottom: constPadding,
                                                    right: leftRightPadding)
        tableToDisplay?.register(CustomTableViewCell.self,
                                 forCellReuseIdentifier: cellConst)
        
        self.view.addSubview(tableToDisplay!)
        
        
        tableToDisplay?.enableAutolayout()
        tableToDisplay?.leadingMargin(pixel: constPadding)
        tableToDisplay?.trailingMargin(pixel: constPadding)
        tableToDisplay?.topMargin(pixel: constPadding)
        tableToDisplay?.bottomMargin(pixel: constPadding)
        
        //2. Add Activity indicator
        activityIndicatorObj = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorObj?.startAnimating()
        activityIndicatorObj?.color = UIColor.black
       
        
        self.tableToDisplay?.addSubview(activityIndicatorObj!)
        
        activityIndicatorObj?.enableAutolayout()
        activityIndicatorObj?.centerX()
        activityIndicatorObj?.centerY()
        activityIndicatorObj?.fixWidth(pixel: activityWidthHeight)
        activityIndicatorObj?.fixHeight(pixel: activityWidthHeight)
        
        //3. Add Label
        errorLabel = UILabel()
        errorLabel?.textColor = UIColor.black
        errorLabel?.text = ""
        errorLabel?.isHidden = true
        
        self.tableToDisplay?.addSubview(errorLabel!)
        
        errorLabel?.enableAutolayout()
        errorLabel?.centerX()
        errorLabel?.centerY()
        errorLabel?.fixWidth(pixel: errorLblWidth)
        errorLabel?.fixHeight(pixel: errorLblHeight)
        
    }
    
    //MARK: - UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if webArr.count > 0
        {
            return webArr.count
        }
        else
        {
            return 1
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellConst) as! CustomTableViewCell
        
        if (self.webArr.count > 0 )
        {
             self.errorLabel?.text = ""
            let cellData = self.webArr[indexPath.row]
            
            cell.titleLabel?.text = cellData["login"] as? String
            cell.subtitleLabel?.text = cellData["node_id"] as? String
            
            let imgUrl = cellData["avatar_url"] as! String
            cell.displayImg?.downloaded(from: imgUrl, contentMode: .scaleAspectFit)
             self.activityIndicatorObj?.stopAnimating()
            
        }
        
 
       
        return cell
    }
}


