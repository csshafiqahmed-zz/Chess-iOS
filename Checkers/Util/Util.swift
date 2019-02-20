//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public class Util {

    /// Generate a 6 digit code for gameUid
    public func generateGameUid() -> String {
        var result = ""
        repeat {
            result = String(format:"%06d", arc4random_uniform(1000000) )
        } while result.count < 6
        return result
    }
}