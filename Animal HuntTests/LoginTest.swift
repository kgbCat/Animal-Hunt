//
//  LoginTest.swift
//  Animal HuntTests
//
//  Created by Anna Delova on 5/30/22.
//

import XCTest
@testable import Animal_Hunt

class LoginTest: XCTestCase {

    var presenter: LoginPresenter!
    
    override func setUpWithError() throws {
       presenter = LoginPresenter()
    }

    override func tearDownWithError() throws {
       presenter = nil
        try super.tearDownWithError()
    }

    func testIfUserExist() {
        // given (дано)
        let word = "Mao"
        // when (когда)
        let result = presenter.checkUser(word: word)
        // then (тогда)
        XCTAssertEqual(result, false, Constants.wrongSecret)
    }

}
