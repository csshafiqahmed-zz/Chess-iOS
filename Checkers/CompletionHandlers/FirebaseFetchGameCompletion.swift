//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import FirebaseCore
import FirebaseDatabase

public enum FirebaseFetchGameCompletion {
    case success(_ snapshot: DataSnapshot)
    case failure
}
