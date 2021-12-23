//
//  KeyChordsServiceTests.swift
//  mwm-chordsTests
//
//  Created by papuruu on 23/12/2021.
//

@testable import mwm_chords
import Foundation
import XCTest

class KeyChordsServiceTests: XCTestCase {
    func testGetKeyChordsShouldPostFailedCallbackIfError() {
        let keyChordsService = KeyChordsService(keyChordsSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.ChordTonesError.self as? Error))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        keyChordsService.getKeyChords { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetKeyChordsShouldPostFailedCallbackIfNoData() {
        let keyChordsService = KeyChordsService(keyChordsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        keyChordsService.getKeyChords { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetKeyChordsShouldPostFailedCallbackIfIncorrectResponse() {
        let keyChordsService = KeyChordsService(keyChordsSession: URLSessionFake(data: FakeResponseData.keyChordsCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        keyChordsService.getKeyChords { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetKeyChordsShouldPostFailedCallbackIfIncorrectData() {
        let keyChordsService = KeyChordsService(keyChordsSession: URLSessionFake(data: FakeResponseData.keyChordsIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        keyChordsService.getKeyChords { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetKeyChordsShouldPostSuccessCallbackIfCorrectDataAndCorrectResponse() {
        let keyChordsService = KeyChordsService(keyChordsSession: URLSessionFake(data: FakeResponseData.chordTonesCorrectData, response: FakeResponseData.responseKO, error: nil))

        let expectation = XCTestExpectation(description: "waiting for queue change")
        keyChordsService.getKeyChords { result in
            guard case .success(let results) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(results)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
