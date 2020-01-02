

import Foundation
import SystemConfiguration

/// Reachability class is used to determine if network is currently reachable or not
/// It makes use of several Low Level Object and APIs
class Reachability {
  
  //MARK: Instance Variables
  /// hostname
  var hostname: String?
  
  /// bool to find is running
  var isRunning = false
  
  /// bool to find the network reachable status
  var isReachableOnWWAN: Bool
  
  /// SCNetworkReachability obj
  var reachability: SCNetworkReachability?
  
  /// SCNetworkReachabilityFlags refernce
  var reachabilityFlags = SCNetworkReachabilityFlags()
  
  //MARK:Constant
  /// serial queque obj
  let reachabilitySerialQueue = DispatchQueue(label: "ReachabilityQueue")
  
  //MARK: Functions
  //MARK: Object Life Cycle
  /// initialize with host name and throws error
  init?(hostname: String) throws {
    guard let reachability = SCNetworkReachabilityCreateWithName(nil, hostname) else {
      throw Network.Error.failedToCreateWith(hostname)
    }
    self.reachability = reachability
    self.hostname = hostname
    isReachableOnWWAN = true
  }
  
  /// init method
  init?() throws {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    guard let reachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }}) else {
        throw Network.Error.failedToInitializeWith(zeroAddress)
    }
    self.reachability = reachability
    isReachableOnWWAN = true
  }
  
  /// status of network based in Wifi and wwan
  var status: Network.Status {
    return  !isConnectedToNetwork ? .unreachable :
      isReachableViaWiFi    ? .wifi :
      isRunningOnDevice     ? .wwan : .unreachable
  }
  
  /// true if  is runnung on 32 and 64 bit or iOS
  var isRunningOnDevice: Bool = {
    #if (arch(i386) || arch(x86_64)) && os(iOS)
      return false
    #else
      return true
    #endif
  }()
  /// deinit method
  deinit { stop() }
}

/// extension for additional functionality
extension Reachability {
  
  /// start the reachability operation
  func start() throws {
    guard let reachability = reachability, !isRunning else { return }
    var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
    context.info = Unmanaged<Reachability>.passUnretained(self).toOpaque()
    guard SCNetworkReachabilitySetCallback(reachability, callout, &context) else { stop()
      throw Network.Error.failedToSetCallout
    }
    guard SCNetworkReachabilitySetDispatchQueue(reachability, reachabilitySerialQueue) else { stop()
      throw Network.Error.failedToSetDispatchQueue
    }
    reachabilitySerialQueue.async { self.flagsChanged() }
    isRunning = true
  }
  
  /// stop the network fetching process
  func stop() {
    defer { isRunning = false }
    guard let reachability = reachability else { return }
    SCNetworkReachabilitySetCallback(reachability, nil, nil)
    SCNetworkReachabilitySetDispatchQueue(reachability, nil)
    self.reachability = nil
  }
  
  /// returns true if network is reachable
  var isConnectedToNetwork: Bool {
    return isReachable &&
      !isConnectionRequiredAndTransientConnection &&
      !(isRunningOnDevice && isWWAN && !isReachableOnWWAN)
  }
  
  /// returns true if reachable via WiFi
  var isReachableViaWiFi: Bool {
    return isReachable && isRunningOnDevice && !isWWAN
  }
  
  /// Flags that indicate the reachability of a network node name or address, including whether a connection is required, and whether some user intervention might be required when establishing a connection.
  var flags: SCNetworkReachabilityFlags? {
    guard let reachability = reachability else { return nil }
    var flags = SCNetworkReachabilityFlags()
    return withUnsafeMutablePointer(to: &flags) {
      SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
      } ? flags : nil
  }
  
  /// compares the current flags with the previous flags and if changed posts a flagsChanged notification
  func flagsChanged() {
    guard let flags = flags, flags != reachabilityFlags else { return }
    reachabilityFlags = flags
    
    if self.status == .unreachable{
      //SharedClass.sharedInstance.isInternetConnected = false
    
    }
    else{
      //SharedClass.sharedInstance.isInternetConnected = true
    }
    NotificationCenter.default.post(name: .flagsChanged, object: self)
  }
  
  /// The specified node name or address can be reached via a transient connection, such as PPP.
  var transientConnection: Bool { return flags?.contains(.transientConnection) == true }
  
  /// The specified node name or address can be reached using the current network configuration.
  var isReachable: Bool { return flags?.contains(.reachable) == true }
  
  /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set, the kSCNetworkReachabilityFlagsConnectionOnTraffic flag, kSCNetworkReachabilityFlagsConnectionOnDemand flag, or kSCNetworkReachabilityFlagsIsWWAN flag is also typically set to indicate the type of connection required. If the user must manually make the connection, the kSCNetworkReachabilityFlagsInterventionRequired flag is also set.
  var connectionRequired: Bool { return flags?.contains(.connectionRequired) == true }
  
  /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. Any traffic directed to the specified name or address will initiate the connection.
  var connectionOnTraffic: Bool { return flags?.contains(.connectionOnTraffic) == true }
  
  /// The specified node name or address can be reached using the current network configuration, but a connection must first be established.
  var interventionRequired: Bool { return flags?.contains(.interventionRequired) == true }
  
  /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. The connection will be established "On Demand" by the CFSocketStream programming interface (see CFStream Socket Additions for information on this). Other functions will not establish the connection.
  var connectionOnDemand: Bool { return flags?.contains(.connectionOnDemand) == true }
  
  /// The specified node name or address is one that is associated with a network interface on the current system.
  var isLocalAddress: Bool { return flags?.contains(.isLocalAddress) == true }
  
  /// Network traffic to the specified node name or address will not go through a gateway, but is routed directly to one of the interfaces in the system.
  var isDirect: Bool { return flags?.contains(.isDirect) == true }
  
  /// The specified node name or address can be reached via a cellular connection, such as EDGE or GPRS.
  var isWWAN: Bool { return flags?.contains(.isWWAN) == true }
  
  /// The specified node name or address can be reached using the current network configuration, but a connection must first be established. If this flag is set
  /// The specified node name or address can be reached via a transient connection, such as PPP.
  var isConnectionRequiredAndTransientConnection: Bool {
    return (flags?.intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]) == true
  }
}

/// callout for sending the network flag changed notification post
func callout(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
  guard let info = info else { return }
  DispatchQueue.main.async {
    Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue().flagsChanged()
  }
}

/// NSNotification
extension NSNotification.Name {
  
  /// holds flags changed values
  static let flagsChanged = NSNotification.Name("FlagsChanged")
}

/// structure for network
struct Network {
  
  /// reachability obj
  static var reachability: Reachability?
  
  /// Enum to handle status of network
  enum Status: String, CustomStringConvertible {
    /// wifi, unreachable, wwan
    case unreachable, wifi, wwan
    
    /// returns description in text
    var description: String { return rawValue }
  }
  
  /// Enum for error
  enum Error: Swift.Error {
    case failedToSetCallout
    case failedToSetDispatchQueue
    case failedToCreateWith(String)
    case failedToInitializeWith(sockaddr_in)
  }
}



