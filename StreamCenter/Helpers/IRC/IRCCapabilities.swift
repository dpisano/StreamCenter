//
//  IRCCapabilities.swift
//  GamingStreamsTVApp
//
//  Created by Olivier Boucher on 2015-10-17.
//  Copyright © 2015 Rivus Media Inc. All rights reserved.
//

import Foundation

class IRCCapabilities {
    fileprivate var capabilities : [String]
    
    init(){
        capabilities = [String]()
    }
    
    init(capabilities : [String]){
        self.capabilities = capabilities
    }
    
    func addCapabilities(_ capabilities : [String]) {
        self.capabilities.append(contentsOf: capabilities)
    }
    
    func getIRCCommandString() -> String? {
        if capabilities.count > 0 {
            var cmd = "CAP REQ :"
        
            for i in 0..<capabilities.count {
                cmd += capabilities[i]
                if i != capabilities.count - 1 {
                    cmd += " "
                }
            }
        
            return cmd
        }
        return nil
    }
}
