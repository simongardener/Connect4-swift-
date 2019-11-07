//
//  GamePlay.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import Foundation

class Connect4Game {
    
    enum directions : Int{
        case northEast = 0
        case east
        case southEast
        case south
        case southWest
        case west
        case northWest
    }
    
    let delegate: ConnectBoardProtocol
    let offset: [BoardPosition]
    var turnsTaken : Int
    var whoseGo: CounterColour
    var gameBoard: Board
    
    init(delegate:ConnectBoardProtocol) {
        self.delegate = delegate
        offset = [BoardPosition(column:1, row:1),BoardPosition(column:1, row:0),BoardPosition(column:1 , row:-1),BoardPosition(column:0 , row:-1),BoardPosition(column:-1,row:-1),BoardPosition(column: -1, row:0),BoardPosition(column:-1 , row:1)]
        turnsTaken = 0
        whoseGo = CounterColour.yellow
        gameBoard = Board()
    }
    func startGame(){
        gameBoard = Board()
        delegate.reloadBoard()
        delegate.setInterfaceForPlaying()
        whoseGo = whoGoesFirst()
        delegate.updateGameStatusLabel(with: "Your turn, \(getPlayerNames()[whoseGo.rawValue])")
    }
    
    func whoGoesFirst() -> CounterColour{
        let playsFirst = arc4random_uniform(2)
        if playsFirst == 0{
            return .yellow
        } else {
            return .red
        }
    }
    
    func getPlayerNames() -> [String]{
        return UserDefaults.standard.object(forKey: "PlayerNames") as! [String]
        
    }
    func implementMove(at indexPath: IndexPath){
        turnsTaken += 1
        let counter = PlayingCounter(colour: whoseGo)
        let newPosition = self.drillDown(at: indexPath)
        refreshBoardWith(counter: counter, at: newPosition)
        let win = checkForWin(from: newPosition, colour: counter.colour)
        if win == true {
            handleWin(counter: counter)
        } else {
            if turnsTaken >=  42 {
                handleDraw()
            } else{
                if whoseGo == .yellow {
                    whoseGo = .red
                } else {
                    whoseGo = .yellow
                }
                delegate.updateGameStatusLabel(with: "Your turn, \(getPlayerNames()[whoseGo.rawValue])")
            }
        }
    }
    
    func handleDraw(){
        delegate.updateGameStatusLabel(with: "Its a draw!")
        delegate.setInterfaceForGameOver()
        turnsTaken = 0
    }
    
    func handleWin(counter: PlayingCounter ) {
        delegate.updateGameStatusLabel(with: "\(getPlayerNames()[counter.colour.rawValue]) wins!")
        delegate.setInterfaceForGameOver()
        turnsTaken = 0
    }
    
    func refreshBoardWith(counter playingCounter: PlayingCounter, at position: BoardPosition){
        gameBoard.columns[position.column].add(playingCounter);
        delegate.reloadBoardPosition(indexPath: CoordinateConverter.viewPosition(for: position))
    }
    
    func checkForWin(from position : BoardPosition, colour :CounterColour) -> Bool {
        
        let southWin = (countConsecuticeCountersOf(colour: colour, from: position, inDirection: offset[directions.south.rawValue]) >= 3)
        if southWin == true {
            changeToGoldStar(at: position)
            highlightWinningCountersOf(colour: colour, from: position, inDirection: offset[directions.south.rawValue])
        }
        
        let eastWestWin = (countConsecuticeCountersOf(colour: colour, from: position, inDirections1: offset[directions.west.rawValue], and2: offset[directions.east.rawValue]) >= 3)
        
        if eastWestWin == true {
            changeToGoldStar(at: position)
            highlightWinningCountersOf(colour: colour, from: position, inDirection1: BoardPosition(column: -1, row: 0 ),and2:BoardPosition(column: 1, row: 0 ))
        }
        let fallingWin = (countConsecuticeCountersOf(colour: colour, from: position, inDirections1: offset[directions.northWest.rawValue], and2: offset[directions.southEast.rawValue]) >= 3)
        
        
        if fallingWin == true {
            changeToGoldStar(at: position)
            highlightWinningCountersOf(colour: colour, from: position, inDirection: BoardPosition(column: -1, row: 1 ))
            highlightWinningCountersOf(colour: colour, from: position, inDirection: BoardPosition(column: 1, row: -1 ))
        }
        let risingWin = (countConsecuticeCountersOf(colour: colour, from: position, inDirections1: offset[directions.southWest.rawValue], and2: offset[directions.northEast.rawValue]) >= 3)
        
        
        if risingWin == true {
            changeToGoldStar(at: position)
            highlightWinningCountersOf(colour: colour, from: position, inDirection: BoardPosition(column: -1, row: -1 ))
            highlightWinningCountersOf(colour: colour, from: position, inDirection: BoardPosition(column: 1, row: 1 ))
        }
        return (southWin || eastWestWin || fallingWin || risingWin)
    }
    
    func countConsecuticeCountersOf(colour: CounterColour, from current: BoardPosition, inDirections1 offset1: BoardPosition, and2 offset2: BoardPosition) -> Int{
        
        return countConsecuticeCountersOf(colour: colour, from: current, inDirection: offset1)
            + countConsecuticeCountersOf(colour: colour, from: current, inDirection: offset2)
    }
    
    func countConsecuticeCountersOf(colour : CounterColour, from current: BoardPosition, inDirection offset: BoardPosition) -> Int{
        let theCounterStatus : PositionStatus = colour == .yellow ? .yellow : .red
        guard let newPosition = generateNewPosition(from: current, inDirection: offset) else { return 0 }
        guard gameBoard.counterExists(at: newPosition) else { return 0 }
        guard gameBoard.counterStatus(at: newPosition) ==  theCounterStatus else { return 0 }
        
        return 1 + countConsecuticeCountersOf(colour: colour, from: newPosition, inDirection: offset)
    }
    
    func highlightWinningCountersOf(colour: CounterColour, from current: BoardPosition, inDirection1  offset1: BoardPosition, and2 offset2: BoardPosition) {
        highlightWinningCountersOf(colour: colour, from: current, inDirection: offset1)
        highlightWinningCountersOf(colour: colour, from: current, inDirection: offset2)
    }
    
    func highlightWinningCountersOf(colour: CounterColour, from current: BoardPosition, inDirection offset: BoardPosition) {
        let theCounterStatus : PositionStatus = colour == .yellow ? .yellow : .red
        guard let newPosition = generateNewPosition(from: current, inDirection: offset) else { return}
        guard gameBoard.counterExists(at: newPosition) else { return }
        guard gameBoard.counterStatus(at: newPosition) ==  theCounterStatus else { return  }
        
        changeToGoldStar(at: newPosition)
        highlightWinningCountersOf(colour: colour, from: newPosition, inDirection: offset)
    }
    
    func changeToGoldStar(at position:BoardPosition){
        gameBoard.columns[position.column].counters[position.row].colour = .gold
        delegate.reloadBoardPosition(indexPath: CoordinateConverter.viewPosition(for: position))
    }
    
    func generateNewPosition(from current: BoardPosition, inDirection offset: BoardPosition ) -> BoardPosition?{
        let newPosition = BoardPosition(column: current.column + offset.column, row: current.row + offset.row)
        if positionIsValidBoardPosition(newPosition) == true {
            return newPosition
        }
        return nil
    }
    
    func positionIsValidBoardPosition(_ newPosition:BoardPosition) -> Bool  {
        if newPosition.column < 0 || newPosition.column > 6 || newPosition.row < 0  || newPosition.row > 5 {
            return false
        }else {
            return true
        }
    }
    
    func drillDown(at indexPath: IndexPath) -> BoardPosition{
        let position = CoordinateConverter.modelPosition(for: indexPath)
        let column = (position.column)
        let newPosition = BoardPosition(column: column, row:gameBoard.columns[column].counters.count)
        return newPosition
    }
}
