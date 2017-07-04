//
//  GameTests.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import XCTest
@testable import Connect4

class GameTests: XCTestCase {
    var sut : Connect4Game!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard.init(name:"Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Connect4VC") as! Connect4ViewController
        _ = viewController.view
        //  let viewController = Connect4ViewController()
        
        sut = Connect4Game(delegate: viewController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPositionIsValidBoardPositionShouldReturnCorrectBool() {
        
        XCTAssertTrue(sut.positionIsValidBoardPosition(BoardPosition(column: 0 , row: 0)))
        XCTAssertFalse(sut.positionIsValidBoardPosition(BoardPosition(column: -1, row: 4)))
        XCTAssertFalse(sut.positionIsValidBoardPosition(BoardPosition(column: 3, row: 9)))
        XCTAssertFalse(sut.positionIsValidBoardPosition(BoardPosition(column: 1, row: -1)))
    }
    
    func testGenerateNewPosition_ShouldReturnObject() {
        
        XCTAssertNotNil(sut.generateNewPosition(from: BoardPosition(column: 1, row: 1), inDirection: BoardPosition(column: 1, row: -1) ))
    }
    
    func testGenerateNewPosition_ShouldReturnCorrectPosition() {
        
        if let x = sut.generateNewPosition(from: BoardPosition(column: 1, row: 1), inDirection: BoardPosition(column: 1, row: -1)) {
            XCTAssertEqual( x.column  , 2)
            XCTAssertEqual(x.row, 0)
            
        }
    }
    
    func testCountConsecutiveCounters_ShouldReturnCorrectVlaue() {
        
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        
        XCTAssertEqual(sut.countConsecuticeCountersOf(colour: .red, from: BoardPosition(column: 4, row: 0), inDirection: BoardPosition(column: 0, row: 1)), 2)
        
        XCTAssertNotEqual(sut.countConsecuticeCountersOf(colour: .red, from: BoardPosition(column: 4, row: 0), inDirection: BoardPosition(column: 0, row: -1)), 2)
    }
    func testWhoGoesFirst_ShouldReturnCounterColourOfYellowOrRed(){
        XCTAssertNotEqual(sut.whoGoesFirst(), CounterColour.gold)
    }
    
    func testDrillDown_shouldReturnCorrectFirstEmptyRow(){
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        let result = sut.drillDown(at: IndexPath(item: 4, section: 0))
        XCTAssertEqual(result.column , 4 )
        XCTAssertEqual(result.row, 3)
    }
    
    func testChangeToGoldStar_ShouldChangeCounterToGold(){
        sut.gameBoard.columns[4].add(PlayingCounter(colour: .red))
        sut.changeToGoldStar(at: BoardPosition(column: 4, row: 0))
        let counterColour = sut.gameBoard.counter(at: BoardPosition(column: 4, row: 0)).colour
        XCTAssertEqual(counterColour, .gold)
    }
    
    func testCheckForWin_ShouldReturnTrue(){
        sut.gameBoard.columns[0].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[1].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[2].add(PlayingCounter(colour: .red))
        sut.gameBoard.columns[3].add(PlayingCounter(colour: .red))
        XCTAssertTrue(sut.checkForWin(from: BoardPosition(column: 1, row:0 ), colour: .red))
    }
    
    func testCheckForWin_ShouldReturnFalse(){
        XCTAssertFalse(sut.checkForWin(from: BoardPosition(column: 1, row:0 ), colour: .red))
    }
    func testHandleDraw_ShouldSetTurnsTakenToZero(){
        sut.handleDraw()
        XCTAssertEqual(sut.turnsTaken, 0)
    }
    func testHandleWin_ShouldSetTurnsTakenToZero(){
        sut.handleWin(counter: PlayingCounter(colour: .red))
        XCTAssertEqual(sut.turnsTaken, 0)
    }
}
