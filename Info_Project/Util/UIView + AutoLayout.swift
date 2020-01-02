
import Foundation
import UIKit

/// This class is Extension to UIView and utilise to customise the
/// view's frame and layouts which adjusts as per screen size
/// all the methods can be accessed with instance of any UIView class or UIView subclass
/// usage
/// enableAutoLayout() first then
/// set other constraints as required
extension UIView
{
  // MARK:
  /// Method to enable auto layout constraints
  func enableAutolayout () -> Void
  {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  /// Method adds leading margin constraint to the View from its Superview using the `pixel` parameter as distance in points
  ///
  /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func leadingMargin (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds trailing margin constraint to the View from its Superview using the `pixel` parameter as distance in points
    ///
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func trailingMargin (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: -pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds top margin constraint to the View from its Superview using the `pixel` parameter as distance in points
    ///
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func topMargin (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds bottom margin constraint to the View from its Superview using the `pixel` parameter as distance in points
    ///
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func bottomMargin (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -pixel)
    self.superview?.addConstraint(constraint)
  }

    /// Method adds flexible bottom margin constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// Flexible margin indicates value would be between zero and the `pixel` value , depending of the size of the superview
    ///
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func flexibleBottomMargin (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -pixel)
    self.superview?.addConstraint(constraint)
  }

  // MARK: Frame Constraints
    /// Method adds fixed width constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// Adds width to the view
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func fixWidth (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds fixed height constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// Adds fixed height to the view
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func fixHeight (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds flexible width greater constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// flexible width indicates minimum width should be equal `pixel` parameter and may increase depending on superview's frame
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func flexibleWidthGreater (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds flexible width smaller constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// flexible width indicates maximum width should be equal `pixel` parameter and may decrease depending on superview's frame
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func flexibleWidthSmaller (pixel : CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds flexible height greater constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// flexible height indicates minimum height should be equal `pixel` parameter and may increase depending on superview's frame
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func flexibleHeightGreater (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method adds flexible height smaller constraint to the View from its Superview using the `pixel` parameter as distance in points
    /// flexible height indicates maximum height should be equal `pixel` parameter and may decrease depending on superview's frame
    /// - Parameter pixel: CGFloat value to draw point distance from the view's superview
  func flexibleHeightSmaller (pixel : CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }

  // MARK: View centering constraints
    
  /// Method to center the view to its superview horizontally on X axis
  func centerX ()
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method to center the view to its superview vertically on Y axis
  func centerY ()
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
    self.superview?.addConstraint(constraint)
  }

    
  /// Method to center the view to the passed `view` object horizontally on X axis
  ///
  /// - Parameter view: UIView object using which the calling view must be centered
  func centerXToView (view: UIView)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method to center the view to the passed `view` object vertically on Y axis
    ///
    /// - Parameter view: UIView object using which the calling view must be centered
  func centerYToView (view: UIView)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
    self.superview?.addConstraint(constraint)
  }
  
  // MARK: Constraints for adding views with respect to neighbouring views
    
  /// Method to add the calling view to the right of the passed `view` parameter with `pixel` as distance in points
  ///
  /// - Parameters:
  ///   - view: UIView object
  ///   - pixel: CGFloat value indicating the distance between the two views
  func addToRight (view:UIView, pixel:CGFloat)
  {
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }

    /// Method to add the calling view to the left of the passed `view` parameter with `pixel` as distance in points
    ///
    /// - Parameters:
    ///   - view: UIView object
    ///   - pixel: CGFloat value indicating the distance between the two views
  func addToLeft (view:UIView, pixel:CGFloat)
  {
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: -pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method to add the calling view below passed `view` parameter with `pixel` as distance in points
    ///
    /// - Parameters:
    ///   - view: UIView object
    ///   - pixel: CGFloat value indicating the distance between the two views
  func addToBelow (view:UIView, pixel:CGFloat)
  {
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: pixel)
    self.superview?.addConstraint(constraint)
  }
  
    /// Method to add the calling view above passed `view` parameter with `pixel` as distance in points
    ///
    /// - Parameters:
    ///   - view: UIView object
    ///   - pixel: CGFloat value indicating the distance between the two views
  func addToAbove (view:UIView, pixel:CGFloat)
  {
    let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: -pixel)
    self.superview?.addConstraint(constraint)
  }
    
  
  /// Method to set the view to horizontally center the calling view from its superview , but used `pixel` value as reference
  ///
  /// - Parameter pixel: CGFloat value passed for centering the view
  func setCenterX (pixel: CGFloat)
  {
    let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: pixel)
        constraint.identifier = "centerX"
    self.superview?.addConstraint(constraint)
  }
    
    /// Method to set the view to vertically center the calling view from its superview , but used `pixel` value as reference
    ///
    /// - Parameter pixel: CGFloat value passed for centering the view
    func setCenterY (pixel: CGFloat)
    {
        let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: pixel)
        constraint.identifier = "centerY"
        self.superview?.addConstraint(constraint)
    }
    
    /// Method to set equal width to the calling view to the passed `view` parameter , so both views have the same width
    /// - Note: The width of the views maybe computed by the system depending on other constraints of the views.
    ///
    /// - Parameter view: UIView object used for width reference
    func equalWidthToView (view:UIView)
    {
        let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0)
        constraint.identifier = "centerY"
        self.superview?.addConstraint(constraint)
    }
    
    /// Method to set equal height to the calling view to the passed `view` parameter , so both views have the same width
    /// - Note: The height of the views maybe computed by the system depending on other constraints of the views.
    ///
    /// - Parameter view: UIView object used for height reference
    func equalHeightToView (view:UIView)
    {
        let constraint = NSLayoutConstraint (item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.0, constant: 0)
        constraint.identifier = "centerY"
        self.superview?.addConstraint(constraint)
    }

}
