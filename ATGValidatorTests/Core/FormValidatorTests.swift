//
//  FormValidatorTests.swift
//  ATGValidatorTests
//
//  Created by Suraj Thomas K on 9/11/18.
//  Copyright © 2019 Al Tayer Group LLC.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import ATGValidator

// TODO: Add unit tests for adding elements with different policies.

class FormValidatorTests: XCTestCase {

    private let form = FormValidator()
    private let textfield = UITextField()
    private let textView = UITextView()

    override func setUp() {

        super.setUp()

        textfield.validationRules = [StringLengthRule.min(8)]
        textView.validationRules = [StringLengthRule.max(10)]

        form.add(textfield)
        form.add(textView)
    }

    func testFormFailure() {

        textfield.text = "Hello"
        textView.text = "Holas"

        form.handler = { (result) in

            XCTAssertEqual(result.status, .failure)
            XCTAssertEqual(result.errors as? [ValidationError], [ValidationError.shorterThanMinimumLength])
        }

        form.validateForm()
    }

    func testFormSuccess() {

        textfield.text = "HelloMisterPerera"
        textView.text = "Holas"

        form.handler = { (result) in

            XCTAssertEqual(result.status, .success)
            XCTAssertNil(result.errors)
        }

        form.validateForm()
    }
}
