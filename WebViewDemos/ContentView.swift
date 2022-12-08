//
//  ContentView.swift
//  WebViewDemos
//
//  Created by Mark Norgren on 12/8/22.
//

import SwiftUI
import WebKit
import SafariServices

struct ContentView: View {
    var body: some View {
        WebViewDemo()
        .padding()
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let delegate: SafariDelegate?

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = delegate
        return safariVC
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }

}

class SafariDelegate: NSObject, SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("didLoadSuccessfully: \(didLoadSuccessfully)")
    }

    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print("initialLoadDidRedirectTo: \(URL.absoluteString)")
    }
}

struct WebViewDemo: View {
    @State private var showSafari = false
    @State private var showWebView = false
    @State private var safariViewDelegate = SafariDelegate()

    var body: some View {
        VStack {

                Button("SFSafariViewController") {
                    self.showSafari = true
                }
                .sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: "https://www.apple.com")!, delegate: safariViewDelegate)
                }

                Button("WKWebView") {
                    self.showWebView = true
                }
                .sheet(isPresented: $showWebView) {
                    // WKWebView to display a website
                    WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
