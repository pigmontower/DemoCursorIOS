//
//  AirConditionerView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI
import UIKit

// MARK: - エアコン画面メインView
struct AirConditionerView: View {
    @StateObject private var viewModel = AirConditionerViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景色
                Color(hex: 0x1a1a2e)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // ヘッダー
                    headerView
                    
                    // メインコンテンツ
                    switch viewModel.currentState {
                    case .initial:
                        InitialStateView(
                            onStartButtonTapped: {
                                viewModel.startAirConditioner()
                            }
                        )
                    case .requesting:
                        RequestingStateView()
                    case .completed:
                        CompletedStateView(
                            remainingTime: viewModel.remainingTime,
                            onStopButtonTapped: {
                                viewModel.stopAirConditioner()
                            }
                        )
                    }
                }
            }
            .navigationBarHidden(true)
            .statusBarStyle(.lightContent)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onDisappear {
            viewModel.onDisappear()
        }
    }
    
    // MARK: - ヘッダーView
    private var headerView: some View {
        HStack {
            // 戻るボタン
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
            }
            
            Spacer()
            
            // タイトル
            Text("エアコン")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            // ヘルプボタン（リクエスト中は非表示）
            if viewModel.currentState != .requesting {
                Button(action: {
                    // ヘルプ画面表示
                }) {
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
            } else {
                // スペースを保持するための透明なView
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.clear)
                    .font(.system(size: 18))
            }
        }
        .padding(.horizontal, 24)
        .frame(height: 64)
        .background(Color(hex: 0x1a1a2e))
    }
    

}

// MARK: - 初期表示画面
struct InitialStateView: View {
    let onStartButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // 説明テキスト
            VStack(spacing: 8) {
                Text("下記の設定でエアコンを起動します。")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("よろしいですか？")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            // 設定表示エリア
            VStack(spacing: 0) {
                // 上境界線
                Rectangle()
                    .fill(Color(hex: 0x333333))
                    .frame(height: 1)
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                
                // 設定ヘッダー
                HStack {
                    Text("エアコンの設定")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        // 設定変更画面表示
                    }) {
                        Text("変更する")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: 0xff4444))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                
                // 起動時間表示
                VStack(spacing: 8) {
                    Text("起動時間")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: 0x888888))
                    
                    Text("10分間")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.top, 24)
                .padding(.bottom, 32)
                
                // 下境界線
                Rectangle()
                    .fill(Color(hex: 0x333333))
                    .frame(height: 1)
                    .padding(.horizontal, 24)
            }
            
            Spacer()
            
            // 起動ボタン
            Button(action: onStartButtonTapped) {
                Text("この設定で起動する")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(hex: 0xff4444))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
    }
}

// MARK: - リクエスト中画面
struct RequestingStateView: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // ステータス表示
            Text("リクエスト中")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.top, 48)
            
            // ローディングインジケーター
            Image(systemName: "arrow.2.circlepath")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: 0xff4444))
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }
                .padding(.top, 24)
            
            // 区切り線
            Rectangle()
                .fill(Color(hex: 0x333333))
                .frame(height: 1)
                .padding(.horizontal, 24)
                .padding(.top, 48)
            
            // 動作中設定表示
            Text("この設定で動作中")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: 0x888888))
                .padding(.top, 24)
            
            // 起動時間表示
            VStack(spacing: 8) {
                Text("起動時間")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: 0x888888))
                
                Text("-- --")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            .padding(.top, 16)
            
            Spacer()
            
            // 停止ボタン（無効化）
            Button(action: {}) {
                Text("停止する")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(hex: 0x666666))
                    .cornerRadius(8)
            }
            .disabled(true)
            .padding(.horizontal, 24)
            
            // 通知設定エリア
            NotificationSettingsView()
        }
    }
}

// MARK: - 完了画面
struct CompletedStateView: View {
    let remainingTime: Int
    let onStopButtonTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // ステータス表示
            Text("エアコン停止まで")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.top, 48)
            
            // 残り時間表示
            Text("\(remainingTime)分")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 24)
            
            // 区切り線
            Rectangle()
                .fill(Color(hex: 0x333333))
                .frame(height: 1)
                .padding(.horizontal, 24)
                .padding(.top, 48)
            
            // 動作中設定表示
            Text("この設定で動作中")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: 0x888888))
                .padding(.top, 24)
            
            // 起動時間表示
            VStack(spacing: 8) {
                Text("起動時間")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: 0x888888))
                
                Text("10分間")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            .padding(.top, 16)
            
            Spacer()
            
            // 停止ボタン
            Button(action: onStopButtonTapped) {
                Text("停止する")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(hex: 0xff4444))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 24)
            
            // 通知設定エリア
            NotificationSettingsView()
        }
    }
}

// MARK: - 通知設定エリア
struct NotificationSettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 通知設定ヘッダー
            Text("通知設定")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            
            // 通知説明テキスト
            Text("クルマの操作関連通知をONにすると、リモート操作完了時にお知らせします。")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: 0xcccccc))
                .lineSpacing(2)
            
            // 通知設定ボタン
            Button(action: {
                // 通知設定画面表示
            }) {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                    
                    Text("アプリの通知を設定する")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 8)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(hex: 0x2a2a3e)
                .clipShape(
                    RoundedCorner(radius: 16, corners: [.topLeft, .topRight])
                )
        )
        .padding(.top, 32)
    }
}

// MARK: - カスタム角丸Shape
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - ステータスバースタイル拡張
extension View {
    func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        self.onAppear {
            UIApplication.shared.statusBarStyle = style
        }
    }
}

#Preview {
    AirConditionerView()
}
