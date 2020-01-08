//
//  ConnectivityManager.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Reachability

public class ConnectivityManager {
    public static let shared = ConnectivityManager()
    private let reachability = try? Reachability()
    
    public init() {}
    
    /// Using the reachability swift library, listens for connection changes
    /// at request time
    /// - Returns: Whether internet is available or not [true or false]
    public func isConnected() -> Bool {
        var connected: Bool = false
        if reachability?.connection != Reachability.Connection.unavailable {
            connected = true
        }
        return connected
    }
}
