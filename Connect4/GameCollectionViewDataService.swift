//
//  GameCollectionViewDataService.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import UIKit

class GameCollectionViewDataService: NSObject , UICollectionViewDataSource, UICollectionViewDelegate {
    
    var game : Connect4Game
    let numberOfColumns = 7
    let maxNumberOfCountersPerColumn = 6
    
    init(game :Connect4Game) {
        self.game = game
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfColumns
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return maxNumberOfCountersPerColumn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = "cell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! BoardCollectionViewCell
        let positionStatus = game.gameBoard.counterStatus(at: indexPath)
        switch positionStatus {
        case .empty:
            cell.imageView.image = #imageLiteral(resourceName: "Connect4SquareEmpty")
        case .red:
            cell.imageView.image = #imageLiteral(resourceName: "Connect4SquareRed")
        case .yellow:
            cell.imageView.image = #imageLiteral(resourceName: "Connect4SquareYellow")
        case .gold:
            cell.imageView.image = #imageLiteral(resourceName: "Connect4SquareGoldStar")
        }
        cell.isUserInteractionEnabled = !(game.gameBoard.counterExists(at: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.implementMove(at: indexPath)
    }
    
}
