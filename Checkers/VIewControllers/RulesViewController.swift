//
//  RulesViewController.swift
//  Checkers
//
//  Created by Satish Boggarapu on 3/4/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import WebKit

class RulesViewController: UIViewController {

    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        
        let url = URL(string: "https://www.itsyourturn.com/t_helptopic2030.html")
        webView.load(URLRequest(url: url!))
        
        webView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    

}
