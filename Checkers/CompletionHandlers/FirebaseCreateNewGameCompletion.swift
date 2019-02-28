//
//  FirebaseCreateNewGameCompletion.swift
//  Checkers
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public enum FirebaseCreateNewGameCompletion {
    case successfullyCreatedGame
    case failure(_ error: Error)
}
