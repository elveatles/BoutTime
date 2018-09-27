//
//  EventWebViewController.swift
//  BoutTime
//
//  Created by Erik Carlson on 9/26/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit
import WebKit

class EventWebViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var urlToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Empty text to make the button invisible
        closeButton.setTitle("", for: .normal)
        
        // Load urlToLoad if it is set
        if let urlStr = urlToLoad {
            loadURL(urlStr)
            urlToLoad = nil
        }
    }
    
    /// Load the URL in the web view
    func loadURL(_ urlStr: String) {
        // In case the view hasn't loaded yet,
        // store the url and load it in viewDidLoad instead.
        guard webView != nil else {
            urlToLoad = urlStr
            return
        }
        
        guard let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Could not encode URL: \(urlStr)")
            return
        }
        
        guard let url = URL(string: encodedStr) else {
            print("Not a valid URL: \(encodedStr)")
            return
        }
        
        print("loadURL: \(urlStr)")
        print("encodedStr: \(encodedStr)")
        
        let request = URLRequest(url: url)
        webView.load(request)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
