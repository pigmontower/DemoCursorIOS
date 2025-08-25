//
//  AirConditionerView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI

enum AirConditionerState {
    case initial    // 初期表示
    case requesting // リクエスト中
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
                            case .requesting:
                                requestingStateView
                            case .completed:
                                completedStateView
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
                
                // 通知設定エリア（リクエスト中・完了時のみ表示）
                if viewModel.currentState != .initial {
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
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(red: 0.172, green: 0.172, blue: 0.18)) // #2C2C2E
    }
    
    // MARK: - 初期表示状態
    private var initialStateView: some View {
        VStack(spacing: 30) {
            // 設定確認メッセージ
            VStack(spacing: 10) {
                Text("下記の設定でエアコンを起動します。")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                Text("よろしいですか？")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            .padding(.top, 40)
            
            // 設定表示エリア
            VStack(spacing: 20) {
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
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                
                // 起動時間表示
                VStack(spacing: 10) {
                    Text("起動時間")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text("\(viewModel.remainingTime)")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                        Text("分間")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                            .padding(.bottom, 3)
                    }
                }
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            // 実行ボタン
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
            .padding(.bottom, 200)
        }
    }
    
    // MARK: - リクエスト中状態
    private var requestingStateView: some View {
        VStack(spacing: 40) {
            // ステータス表示エリア
            VStack(spacing: 30) {
                Text("リクエスト中")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                // ローディングアニメーション
                Image(systemName: "fan.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                    .rotationEffect(.degrees(viewModel.rotationAngle))
            }
            
            // 動作中設定表示
            VStack(spacing: 20) {
                Text("この設定で動作中")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                
                VStack(spacing: 10) {
                    Text("起動時間")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                    
                    Text("—")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            // 停止ボタン
            Button(action: {
                viewModel.stopAirConditioner()
            }) {
                Text("停止する")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .frame(height: 50)
                    .background(Color(red: 0.235, green: 0.235, blue: 0.243)) // #3C3C3E
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.bottom, 200)
        }
    }
    
    // MARK: - 完了状態
    private var completedStateView: some View {
        VStack(spacing: 40) {
            // 完了ステータスエリア
            VStack(spacing: 20) {
                Text("エアコン停止まで")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
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
            
            // 動作中設定表示
            VStack(spacing: 20) {
                Text("この設定で動作中")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                
                VStack(spacing: 10) {
                    Text("起動時間")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                    
                    HStack(alignment: .bottom, spacing: 5) {
                        Text("\(viewModel.remainingTime)")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("分間")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                            .padding(.bottom, 2)
                    }
                }
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            // 停止ボタン
            Button(action: {
                viewModel.stopAirConditioner()
            }) {
                Text("停止する")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 250)
                    .frame(height: 50)
                    .background(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
