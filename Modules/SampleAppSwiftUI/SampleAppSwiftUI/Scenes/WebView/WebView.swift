//
//  WebView.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 24.07.2023.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL?
    var activityIndicator = UIActivityIndicatorView(
        frame: CGRect(x: (UIScreen.main.bounds.width/Dimensions.WebView.two)-Dimensions.WebView.thirty,
                      y: (UIScreen.main.bounds.height/Dimensions.WebView.two)-Dimensions.WebView.thirty,
                      width: Dimensions.WebView.sixty,
                      height: Dimensions.WebView.sixty)
    )

    func makeUIView(context: Context) -> UIView {
        let view = UIView(
            frame: CGRect(
                x: Dimensions.WebView.zero,
                y: Dimensions.WebView.zero,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        let webview = WKWebView(
            frame: CGRect(
                x: Dimensions.WebView.zero,
                y: Dimensions.WebView.zero,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        webview.navigationDelegate = context.coordinator

        if let url = self.url {
            let request = URLRequest(url: url)
            webview.load(request)
        }
        view.addSubview(webview)
        activityIndicator.backgroundColor = UIColor.systemGray5
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.white
        activityIndicator.layer.cornerRadius = Dimensions.WebView.eight
        activityIndicator.clipsToBounds = true

        view.addSubview(activityIndicator)
        return view
    }

    func makeCoordinator() -> WebViewHelper {
        WebViewHelper(self)
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}

class WebViewHelper: NSObject, WKNavigationDelegate {

    var parent: WebView

    init(_ parent: WebView) {
        self.parent = parent
        super.init()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.activityIndicator.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        parent.activityIndicator.isHidden = true
        Logger().error(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        parent.activityIndicator.isHidden = true
        Logger().error(error.localizedDescription)
    }
}
