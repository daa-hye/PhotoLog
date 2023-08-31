//
//  WebViewController.swift
//  PhotoLog
//
//  Created by 박다혜 on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {

    var webView = WKWebView()

//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }

        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        // 네비게이션 컨트롤러는 처음에 투명, 스크롤하면 불투명

        let appearanvce = UINavigationBarAppearance()
        appearanvce.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearanvce
        navigationController?.navigationBar.scrollEdgeAppearance = appearanvce

        title = "웹뷰"
    }

    func reloadButtonClicked() {
        webView.reload()
    }

    func goBakcButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    func doForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
