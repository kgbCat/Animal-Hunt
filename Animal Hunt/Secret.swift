//
//  Constants.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import Foundation

class Secret {
    
    static let shared = Secret(user: User())

    var user: User

    private init(user: User) {
        self.user = user
    }

}
