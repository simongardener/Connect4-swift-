//
//  Connect4ViewController.swift
//  Connect4
//
//  Created by Simon Gardener on 04/07/2017.
//  Copyright © 2017 Simon Gardener. All rights reserved.
//

import UIKit

class Connect4ViewController: UIViewController, ConnectBoardProtocol  {
    
    @IBOutlet weak var theBoard: UICollectionView!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    //    let numberOfColumns = 7
    //    let maxNumberOfCountersPerColumn = 6
    
    var game: Connect4Game!
    var dataService : GameCollectionViewDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Connect4Game(delegate: self)
        setUpDataService()
        setPlayerNames()
        theBoard.isUserInteractionEnabled = false
    }
    fileprivate func setUpDataService() {
        dataService = GameCollectionViewDataService.init(game: game)
        theBoard.delegate = dataService
        theBoard.dataSource = dataService
    }
    fileprivate func setPlayerNames() {
        player2TextField.text = (UserDefaults.standard.array(forKey: "PlayerNames") as! [String]) [1]
        player1TextField.text = (UserDefaults.standard.array(forKey: "PlayerNames") as! [String]) [0]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func startGame(_ sender: UIButton) {
        game.startGame()
    }
    
    func setInterfaceForPlaying() {
        startButton.isEnabled = false
        theBoard.isUserInteractionEnabled = true
    }
    func setInterfaceForGameOver() {
        startButton.isEnabled = true
        startButton.setTitle("Play Again", for: .normal)
        theBoard.isUserInteractionEnabled = false
    }
    func updateGameStatusLabel(with message: String) {
        gameStatusLabel.text = message;
    }
    func reloadBoardPosition(indexPath: IndexPath) {
        theBoard.reloadItems(at: [indexPath])
    }
    func reloadBoard() {
        theBoard.reloadData()
    }
    
}
