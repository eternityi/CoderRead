//
//  OAuthViewController.swift
//  CoderRead
//
//  Created by qing on 2018/9/10.
//  Copyright © 2018 qing. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    title = "OAuth"
    
    view.addSubview(webView)
    view.addSubview(progressView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.progressView.frame = CGRect(x:0,y:64,width:self.view.frame.size.width,height:2)
    self.progressView.isHidden = false
    UIView.animate(withDuration: 1.0) {
      self.progressView.progress = 0.0
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //webview
  lazy var webView : WKWebView = {
    let web = WKWebView(frame: self.view.frame)
    
    let url = URL(string: "https://api.gitbook.com/oauth/authorize")
    let request = URLRequest(url: url! as URL)
    
    web.navigationDelegate = self
    
    web.load(request as URLRequest)
    
    return web
  }()
  
  // 进度条
  lazy var progressView:UIProgressView = {
    let progress = UIProgressView()
    progress.progressTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    progress.trackTintColor = .clear
    return progress
  }()
  
}

extension OAuthViewController:WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    self.navigationItem.title = "loading..."
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    //
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.title = self.webView.title
    print("finish")
    UIView.animate(withDuration: 0.5) {
      self.progressView.progress = 1.0
      self.progressView.isHidden = true
    }
  }
  
}
