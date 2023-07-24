//
//  WebView.swift
//  SampleAppSwiftUI
//
//  Created by Meryem Şahin on 24.07.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
         print(context)
         return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = self.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
