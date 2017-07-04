//
//  ConnectBoardProtocol.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import Foundation

protocol ConnectBoardProtocol {
    
    func reloadBoard()
    func reloadBoardPosition(indexPath:IndexPath)
    func updateGameStatusLabel(with message: String)
    func setInterfaceForPlaying()
    func setInterfaceForGameOver()
}
