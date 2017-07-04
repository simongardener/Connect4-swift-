//
//  Connect4Tests.swift
//  Connect4Tests
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import XCTest
@testable import Connect4

class Connect4Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testPlayingCounter_ReturnsObject(){
        XCTAssertNotNil(PlayingCounter(colour: .red))
    }
    func testPlayingCounter_ReturnsCounterOfColour() {
        let myCounter = PlayingCounter(colour: .yellow)
        XCTAssertEqual(myCounter.colour, .yellow)
    }
    
    func testColumn_ReturnsObject(){
        let myColumn = Column()
        XCTAssertNotNil(myColumn)
        XCTAssertEqual(myColumn.counters.count, 0)
    }
    
    func testColumn_CanAddCounter() {
        var myColumn = Column()
        myColumn.add(PlayingCounter(colour: .red))
        XCTAssertEqual(myColumn.counters.count, 1)
    }
    func testColumn_CanHoldMax6() {
        var myColumn = Column()
        for _ in 1...7 {
            myColumn.add(PlayingCounter(colour: .red))
        }
        XCTAssertTrue(myColumn.counters.count == 6)
    }
    
    func testBoard_InitializesWith7Columns() {
        let myBoard = Board()
        XCTAssertEqual(myBoard.columns.count, 7)
        
    }
    
    func testBoardCounterExistsAtPosition_Returns() {
        var myBoard = Board()
        myBoard.columns[4].add(PlayingCounter(colour: .red))
        myBoard.columns[4].add(PlayingCounter(colour: .yellow))
        var indexPath = IndexPath(item: 4, section: 5 )
        XCTAssertTrue(myBoard.counterExists(at: indexPath))
        indexPath = IndexPath(item: 5, section: 1)
        XCTAssertFalse(myBoard.counterExists(at: indexPath))
    }
    
    func testCounterAtPosition_IsYellow(){
        var myBoard = Board()
        myBoard.columns[4].add(PlayingCounter(colour: .red))
        myBoard.columns[4].add(PlayingCounter(colour: .yellow))
        let indexPath = IndexPath(item: 4, section: 4
        )
        XCTAssertEqual(myBoard.counter(at: indexPath).colour, .yellow)
    }
}
