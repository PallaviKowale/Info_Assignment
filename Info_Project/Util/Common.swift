
import Foundation
import UIKit

/// Common class is used to common operations performed across the app
class Common: NSObject {
  
  /// shared Instance
  static let commonShared = Common()
  
    //MARK: indicator variable
  var viewLoaderBg : UIView?
  var loaderImgView : UIImageView?
    
  
    
  /// Static Int var indicates the total network operation currently going on
  static var networkOperationCount : Int = 0
  
  
  
  
  
  /// class method to remove the indicator and reset count
  /// of for network operations
  class func removeIndicatorAndResetCount()
  {
    Common.networkOperationCount = 0
    DispatchQueue.main.async {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
  }
  
  ///class method to validate the empty object
  ///returns true if empty
  class func isEmptyObject(object:AnyObject) -> Bool {
    
    return object.isEmpty
  }
  
  
  ///class method to get the jsonstring  object from json
  ///returns string
  class  func jsonString(fromObject object: Any) -> String {
    
    let jsonData: Data? = try? JSONSerialization.data(withJSONObject: object, options: [])
    var jsonString: String? = nil
    if jsonData == nil {
      
    }
    else {
      
      jsonString = String(bytes: jsonData!, encoding: String.Encoding.utf8)
    }
    return jsonString!
  }
  
  ///class method to get the json object from string
  ///returns Object
  class func jsonObject(from string: String) -> Any {
    let error: Error? = nil
    let data: Data? = string.data(using: String.Encoding.utf8)
    let object: Any? = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
    if error != nil || object == nil {
      
      return ["error": "Please check internet connections"]
    }
    else {
      
      return object!
    }
  }
  
  
  
  ///class method to vaidate the object to access is not nil
  ///returns nil if objectForKey return nil
  class  func objectOrNilForKey(aKey: AnyObject, dict: [NSObject: AnyObject])-> AnyObject?
  {
    if dict[aKey as! NSObject] ==  nil {
      return nil
    }
    
    
    let object: AnyObject = dict[aKey as! NSObject]!
    
    return object.isEqual(NSNull()) ? nil : object
  }


}
