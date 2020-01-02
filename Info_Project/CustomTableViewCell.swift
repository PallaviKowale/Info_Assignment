

import UIKit

class CustomTableViewCell: UITableViewCell {
    
     var cellParentView : UIView?
     var titleLabel : UILabel?
     var subtitleLabel : UILabel?
     var displayImg : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        //1.
        cellParentView = UIView()
        self.addSubview(self.cellParentView!)

        cellParentView?.enableAutolayout()
        cellParentView?.leadingMargin(pixel: 5)
        cellParentView?.trailingMargin(pixel: 5)
        cellParentView?.topMargin(pixel: 5)
        cellParentView?.bottomMargin(pixel: 5)
        
        //2.
        displayImg = UIImageView()
        cellParentView?.addSubview(displayImg!)
        
        displayImg?.enableAutolayout()
        displayImg?.leadingMargin(pixel: 10)
        displayImg?.topMargin(pixel: 10)
        displayImg?.fixHeight(pixel: 80)
        displayImg?.fixWidth(pixel: 80)
        
        //3.
        titleLabel = UILabel()
        cellParentView?.addSubview(titleLabel!)
        
        titleLabel?.enableAutolayout()
        titleLabel?.addToRight(view: self.displayImg!, pixel: 10)
        titleLabel?.topMargin(pixel: 10)
        titleLabel?.trailingMargin(pixel: 10)
        titleLabel?.fixHeight(pixel: 20)
        
        //4.
        subtitleLabel = UILabel()
        cellParentView?.addSubview(subtitleLabel!)
        
        self.setMultilineLabel(label: self.subtitleLabel)
        subtitleLabel?.enableAutolayout()
        subtitleLabel?.addToRight(view: self.displayImg!, pixel: 15)
        subtitleLabel?.addToBelow(view: self.titleLabel!, pixel: 20)
        subtitleLabel?.trailingMargin(pixel: 10)
        subtitleLabel?.bottomMargin(pixel: 10)
        //subtitleLabel?.fixHeight(pixel: 20)
    }
    
    func setMultilineLabel(label: UILabel?) {
        
        label?.numberOfLines = 0
        label?.sizeToFit()
        label?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

}
