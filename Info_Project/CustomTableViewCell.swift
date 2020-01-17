

import UIKit

class CustomTableViewCell: UITableViewCell {
    
     var cellParentView : UIView?
     var titleLabel : UILabel?
     var subtitleLabel : UILabel?
     var displayImg : UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        let parentPadding : CGFloat = 5
        let marginPadding : CGFloat = 10
        let heightConst : CGFloat = 80
        let widthConst : CGFloat = 80
        let titleHeight : CGFloat = 20
        
        let subtitleRightPadding : CGFloat = 15
        let subtitleBottomPadding : CGFloat = 20
        
        
        //1.
        cellParentView = UIView()
        self.addSubview(self.cellParentView!)

        cellParentView?.enableAutolayout()
        cellParentView?.leadingMargin(pixel: parentPadding)
        cellParentView?.trailingMargin(pixel: parentPadding)
        cellParentView?.topMargin(pixel: parentPadding)
        cellParentView?.bottomMargin(pixel: parentPadding)
        
        //2.
        displayImg = UIImageView()
        cellParentView?.addSubview(displayImg!)
        
        displayImg?.enableAutolayout()
        displayImg?.leadingMargin(pixel: marginPadding)
        displayImg?.topMargin(pixel: marginPadding)
        displayImg?.fixHeight(pixel: heightConst)
        displayImg?.fixWidth(pixel: widthConst)
        
        //3.
        titleLabel = UILabel()
        cellParentView?.addSubview(titleLabel!)
        
        titleLabel?.enableAutolayout()
        titleLabel?.addToRight(view: self.displayImg!, pixel: marginPadding)
        titleLabel?.topMargin(pixel: marginPadding)
        titleLabel?.trailingMargin(pixel: marginPadding)
        titleLabel?.fixHeight(pixel: titleHeight)
        
        //4.
        subtitleLabel = UILabel()
        cellParentView?.addSubview(subtitleLabel!)
        
        self.setMultilineLabel(label: self.subtitleLabel)
        subtitleLabel?.enableAutolayout()
        subtitleLabel?.addToRight(view: self.displayImg!, pixel: subtitleRightPadding)
        subtitleLabel?.addToBelow(view: self.titleLabel!, pixel: subtitleBottomPadding)
        subtitleLabel?.trailingMargin(pixel: marginPadding)
        subtitleLabel?.bottomMargin(pixel: marginPadding)
    }
    
    func setMultilineLabel(label: UILabel?) {
        
        label?.numberOfLines = 0
        label?.sizeToFit()
        label?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }

}
