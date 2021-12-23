//
//  ChordTonesServiceTests.swift
//  mwm-chordsTests
//
//  Created by papuruu on 22/12/2021.
//

@testable import mwm_chords
import Foundation
import XCTest

class ChordTonesServiceTests: XCTestCase {
    func testGetChordTonesShouldPostFailedCallbackIfError() {
        let chordTonesService = ChordTonesService(sessionChordTones: URLSessionFake(data: nil, response: nil, error: FakeResponseData.ChordTonesError.self as? Error))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        chordTonesService.getChordTones { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordTonesShouldPostFailedCallbackIfNoData() {
        let chordTonesService = ChordTonesService(sessionChordTones: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        chordTonesService.getChordTones { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordTonesShouldPostFailedCallbackIfIncorrectResponse() {
        let chordTonesService = ChordTonesService(sessionChordTones: URLSessionFake(data: FakeResponseData.chordTonesCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        chordTonesService.getChordTones { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordTonesShouldPostFailedCallbackIfIncorrectData() {
        let chordTonesService = ChordTonesService(sessionChordTones: URLSessionFake(data: FakeResponseData.chordTonesIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "waiting for queue change")
        chordTonesService.getChordTones { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordTonesShouldPostSuccessCallbackIfCorrectDataAndCorrectResponse() {
        let chordTonesService = ChordTonesService(sessionChordTones: URLSessionFake(data: FakeResponseData.chordTonesCorrectData, response: FakeResponseData.responseOK, error: nil))

        let expectation = XCTestExpectation(description: "waiting for queue change")
        chordTonesService.getChordTones { result in
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
