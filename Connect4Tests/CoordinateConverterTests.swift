//
//  CoordinateConverterTests.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import XCTest
 @testable import Connect4
class CoordinateConverterTests: XCTestCase {
        
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func testViewPosition_ShouldReturnAnIndexPath() {
            let position = BoardPosition(column: 6, row: 5)
            let indexPath = IndexPath(item: 6, section: 0)
            XCTAssertEqual(CoordinateConverter.viewPosition(for: position), indexPath)
            
            let position2 = BoardPosition(column: 1, row: 1)
            let indexPath2 = IndexPath(item: 1, section: 4)
            XCTAssertEqual(CoordinateConverter.viewPosition(for: position2), indexPath2)
        }
        
        
        func testModelPosition_ShouldReturnABoardPosition() {
            let indexPath = IndexPath(item: 6, section: 0)
            let position = BoardPosition(column: 6, row: 5)
            XCTAssertEqual(CoordinateConverter.modelPosition(for: indexPath).column, position.column)
            XCTAssertEqual(CoordinateConverter.modelPosition(for: indexPath).row, position.row)
        }
}
