//
//  IndexViewController.swift
//  CoderRead
//
//  Created by qing on 2018/9/10.
//  Copyright © 2018 qing. All rights reserved.
//

import UIKit
import Alamofire

//import OAuthViewController

class IndexViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Index"
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func requestAction(_ sender: UIButton) {
    print("https://api.gitbook.com/oauth/authorize")
    requestURL()
  }
  
  fileprivate func requestURL() {
    //1.
    let urlStr: String = String("https://api.gitbook.com/oauth/authorize")
    let oauthurl: URL = URL(string: urlStr)!
    
    //2.
    let request: URLRequest = URLRequest(url: oauthurl as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 100)
    
    //3.
    let session = URLSession.shared
    
    let dataTask = session.dataTask(with: request,
                                    completionHandler: {(data, response, error) -> Void in
      if error != nil {
        print(error!)
      } else {
        let dataStr = String(data: data!, encoding: String.Encoding.utf8)
        //print(dataStr!)
        
        // main thread
        let mainQueue = DispatchQueue.main
        
        mainQueue.async {
          [weak self] in
          let oauthVC = OAuthViewController()
          self!.navigationController?.pushViewController(oauthVC, animated: true)
        }
        
        
      }
    }) as URLSessionTask
    
    dataTask.resume()
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
