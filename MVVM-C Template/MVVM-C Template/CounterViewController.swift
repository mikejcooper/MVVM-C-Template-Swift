//
//  CounterViewController.swift
//  Siddhartha
//
//  Created by Mike Cooper on 14/07/2017.
//  Copyright © 2017 Mike Cooper. All rights reserved.
//


import Foundation
import UIKit
import RxSwift // Binding ViewModel to ViewController : Variable<Type>
// Binding examples: https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Examples.md

class CounterViewController: UIViewController, Coordinated
{
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var persistentLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var coordinationDelegate: CoordinationDelegate?
    var viewModel: CounterViewModel!
    
    override func viewDidLoad(){
        
        self.viewModel.count
            .asObservable()
            .map { $0 }
            .bindTo(self.label.rx.text)
            .addDisposableTo(self.disposeBag)
        
    
    }
    
    
    @IBAction func startAppAgainButtonClicked(_ sender: UIButton) {
        viewModel?.navigateToHomeNavScene()
    }

    @IBAction func incrimentButtonClicked(_ sender: UIButton) {
        viewModel?.incrimentCounter()
    }
    
    @IBAction func decrimentButtonPressed(_ sender: UIButton) {
        viewModel?.decrimentCounter()

    }
}
