//
//  WebView.swift
//  vk_alt_app_test
//
//  Created by Антон Адамсон on 13.04.2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var token: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: "51901884"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "wall,friends"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        
        let req = URLRequest(url: urlComponent.url!)
        webView.load(req)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator { token in
            self.token = token
            print(token)
        }
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    var token: (String) -> ()
    
    init(token: @escaping (String) -> Void) {
        self.token = token
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        if let accessToken = params["access_token"] {
            token(accessToken)
        }
        
        decisionHandler(.cancel)
    }
    
}
