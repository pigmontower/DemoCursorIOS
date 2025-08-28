//
//  AirConditionerView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI

enum AirConditionerState {
    case initial    // 初期表示
    case completed  // 完了
}

struct AirConditionerView: View {
    @StateObject private var viewModel = AirConditionerViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景色（黒）
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // ヘッダー
                    headerView
                    
                    // メインコンテンツ
                    ScrollView {
                        VStack(spacing: 20) {
                            switch viewModel.currentState {
                            case .initial:
                                initialStateView
                            case .completed:
                                completedStateView
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
                
                // 通知設定エリア（完了時のみ表示）
                if viewModel.currentState == .completed {
                    VStack {
                        Spacer()
                        notificationSettingsArea
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onDisappear {
            viewModel.onViewDisappear()
        }
    }
    
    // MARK: - ヘッダー
    private var headerView: some View {
        HStack {
            // 戻るボタン
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .accessibilityIdentifier("backButton")
            .accessibilityLabel("前の画面に戻るボタン")
            
            Spacer()
            
            // タイトル
            Text("エアコン")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            // ヘルプボタン
            Button(action: {
                // ヘルプ処理
            }) {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .accessibilityIdentifier("helpButton")
            .accessibilityLabel("ヘルプボタン。アプリの使い方を確認できます")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(red: 0.172, green: 0.172, blue: 0.18)) // #2C2C2E
    }
    
    // MARK: - 初期表示状態
    private var initialStateView: some View {
        VStack(spacing: 0) {
            // 設定確認メッセージエリア
            VStack(spacing: 10) {
                Text("下記の設定でエアコンを起動します。")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                Text("よろしいですか？")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.172, green: 0.172, blue: 0.18)) // #2C2C2E
            
            // 設定表示エリア
            VStack(spacing: 0) {
                // 設定タイトル
                HStack {
                    Text("エアコンの設定")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        // 設定変更処理
                    }) {
                        Text("変更する")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                
                // 起動時間表示
                VStack(spacing: 10) {
                    HStack {
                        Text("起動時間")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                        Spacer()
                    }
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text("\(viewModel.remainingTime)")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                        Text("分間")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                            .padding(.bottom, 3)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(height: 120)
            
            Spacer()
            
            // 実行ボタンエリア
            VStack {
                Button(action: {
                    viewModel.startAirConditioner()
                }) {
                    Text("この設定で起動する")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 20)
            }
            .frame(height: 80)
            .padding(.bottom, 20)
        }
    }
    

    
    // MARK: - 完了状態
    private var completedStateView: some View {
        VStack(spacing: 0) {
            // 完了ステータスエリア
            VStack(spacing: 20) {
                Text("エアコン停止まで")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                // カウントダウン表示
                HStack(alignment: .bottom, spacing: 5) {
                    Text("\(viewModel.countdownTime)")
                        .font(.system(size: 72, weight: .heavy))
                        .foregroundColor(.white)
                    Text("分")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                }
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            
            // 動作中設定表示エリア
            VStack(spacing: 0) {
                HStack {
                    Text("この設定で動作中")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                
                VStack(spacing: 10) {
                    HStack {
                        Text("起動時間")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                        Spacer()
                    }
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text("\(viewModel.remainingTime)")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("分間")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                            .padding(.bottom, 2)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(height: 120)
            
            Spacer()
            
            // 停止ボタンエリア
            VStack {
                Button(action: {
                    viewModel.stopAirConditioner()
                }) {
                    Text("停止する")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(width: UIScreen.main.bounds.width * 0.7) // 幅70%
            }
            .padding(.bottom, 200)
        }
    }
    
    // MARK: - 通知設定エリア
    private var notificationSettingsArea: some View {
        VStack(spacing: 15) {
            HStack {
                Text("通知設定")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            
            Text("クルマの操作関連通知をONにすると、リモート操作完了時にお知らせします。")
                .font(.system(size: 12))
                .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                .lineLimit(nil)
            
            Button(action: {
                // 通知設定処理
            }) {
                HStack {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                    
                    Text("アプリの通知を設定する")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.clear)
            }
            .accessibilityIdentifier("notificationSettingsButton")
            .accessibilityLabel("通知設定ボタン。アプリの通知設定を変更できます")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color(red: 0.11, green: 0.11, blue: 0.118)) // #1C1C1E
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
    }

}

#Preview {
    AirConditionerView()
}
