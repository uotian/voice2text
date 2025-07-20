//
//  ContentView.swift
//  voice2text
//
//  Created by 内藤芳彦 on 2025/07/20.
//

import SwiftUI
import Speech

struct ContentView: View {
    @State private var isAuthorized = false
    @State private var authorizationStatus = "未確認"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("音声認識権限テスト")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 権限状態表示
            VStack(alignment: .leading, spacing: 10) {
                Text("権限状態:")
                    .font(.headline)
                
                HStack {
                    Text("音声認識:")
                    Text(authorizationStatus)
                        .foregroundColor(isAuthorized ? .green : .red)
                }
                .font(.body)
            }
            .padding()
            .background(Color(.controlBackgroundColor))
            .cornerRadius(8)
            
            // 権限リクエストボタン
            Button("権限をリクエスト") {
                requestAuthorization()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
        .onAppear {
            checkAuthorizationStatus()
        }
    }
    
    private func checkAuthorizationStatus() {
        let status = SFSpeechRecognizer.authorizationStatus()
        updateAuthorizationStatus(status)
    }
    
    private func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                updateAuthorizationStatus(status)
            }
        }
    }
    
    private func updateAuthorizationStatus(_ status: SFSpeechAuthorizationStatus) {
        switch status {
        case .authorized:
            authorizationStatus = "許可済み"
            isAuthorized = true
        case .denied:
            authorizationStatus = "拒否"
            isAuthorized = false
        case .restricted:
            authorizationStatus = "制限"
            isAuthorized = false
        case .notDetermined:
            authorizationStatus = "未決定"
            isAuthorized = false
        @unknown default:
            authorizationStatus = "不明"
            isAuthorized = false
        }
    }
}

#Preview {
    ContentView()
}
