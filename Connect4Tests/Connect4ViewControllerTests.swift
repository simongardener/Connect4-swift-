//
//  Connect4ViewControllerTests.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import XCTest
@testable import Connect4

class Connect4ViewControllerTests: XCTestCase {
    
    var sut : Connect4ViewController!
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard.init(name:"Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "Connect4VC") as! Connect4ViewController)
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVC_CollectionViewShouldNotBeNil(){
        XCTAssertNotNil(sut.theBoard)
    }
    func testVC_StartButtonShouldNotBeNil(){
        XCTAssertNotNil(sut.startButton)
    }
    func testVC_Player1TextFieldShouldNotBeNil(){
        XCTAssertNotNil(sut.player1TextField)
    }
    func testVC_Player2TextFieldShouldNotBeNil(){
        XCTAssertNotNil(sut.player2TextField)
    }
    func testVC_GameStatusLabelShouldNotBeNil(){
        XCTAssertNotNil(sut.gameStatusLabel)
    }
    func testTheBoard_HasDelegate(){
        XCTAssertNotNil(sut.theBoard.delegate)
    }
    func testTheBoard_HasDataSource(){
        XCTAssertNotNil(sut.theBoard.dataSource)
    }
    func testTheBoardDelegate_isTypeGameCollectionViewDataService(){
        XCTAssertTrue(sut.theBoard.delegate is GameCollectionViewDataService)
    }
    func testUpdateGameStatusLabel_ShouldUpdateLabel() {
        let newStatus = "Its getting tense"
        sut.updateGameStatusLabel(with: newStatus)
        XCTAssertEqual(sut.gameStatusLabel.text, newStatus)
    }
    func  testSetInterfaceForPlaying_ShouldEnableBoard(){
        sut.setInterfaceForPlaying()
        XCTAssertTrue(sut.theBoard.isUserInteractionEnabled)
    }
    func  testSetInterfaceForPlaying_ShouldDisableStartButton(){
        sut.setInterfaceForPlaying()
        XCTAssertFalse(sut.startButton.isEnabled)
    }
    func testSetInterfaceForGameOver_ShouldEnableStartButton(){
        sut.setInterfaceForGameOver()
        XCTAssertTrue(sut.startButton.isEnabled)
    }
    func testSetInterfaceForGameOver_ShouldDisableBoard(){
        sut.setInterfaceForGameOver()
        XCTAssertFalse(sut.theBoard.isUserInteractionEnabled)
    }
}
