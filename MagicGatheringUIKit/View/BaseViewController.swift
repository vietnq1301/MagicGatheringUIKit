//
//  BaseViewController.swift
//  DungeonsAndDragons
//
//  Created by Nguyễn Thành Trung on 01/07/2021.
//

import UIKit
import Combine
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    let viewIndicator = UIView()
    var loadingIndicator: NVActivityIndicatorView?
    
    var subscriptions = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupIndicator()
        setupData()
        setupUI()
        bindingToView()
        bindingToViewModel()
        router()
    }
    
    //MARK: - Configuration
    func setupData() {}
    
    func setupUI() {}
    
    func bindingToView() {}
    
    func bindingToViewModel() {}
    
    //MARK: - Navigation
    func router() {}
    
    func setupIndicator() {
        viewIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(viewIndicator)
        viewIndicator.translatesAutoresizingMaskIntoConstraints = false
        viewIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        viewIndicator.heightAnchor.constraint(equalToConstant: 60).isActive = true
        viewIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewIndicator.isHidden = false
        viewIndicator.round(corners: .all)
        
        let frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.lineScale, color: .white, padding: 0)
        viewIndicator.addSubview(loadingIndicator!)
    }
    
    func startAnimating() async {
        Task {
            viewIndicator.isHidden = false
            loadingIndicator?.startAnimating()
        }
    }
    
    func stopAnimating() async {
        Task {
            loadingIndicator?.stopAnimating()
            viewIndicator.isHidden = true
        }
    }
    
}
