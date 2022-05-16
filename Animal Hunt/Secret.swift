//
//  Constants.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import Foundation

class Secret {
    
    static let shared = Secret(secretWord: "" )

    var secretWord: String

    private init(secretWord: String) {
        self.secretWord = secretWord
    }

}
