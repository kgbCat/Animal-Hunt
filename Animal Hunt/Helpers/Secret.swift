//
//  Constants.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import Foundation

class Secret {
    static let shared = Secret(secretWord: String())
    var secretWord: String
    private init(secretWord: String) {
        self.secretWord = secretWord
    }

    func deleteSecret() {
        secretWord = String()
    }

    func updateSecret(_ newWord: String) {
        secretWord = newWord
    }
}
