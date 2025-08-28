//
//  ContentView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAirConditioner = false
    
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
                            // メイン車両表示エリア
                            carImageView
                            
                            // 車両ステータス情報エリア
                            vehicleInfoCard
                            
                            // 警告・通知エリア
                            alertNotificationArea
                            
                            // 操作ボタンエリア
                            functionButtonsView
                            
                            // リモートサービスエリア
                            remoteServiceArea
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100) // フッターの高さ分
                    }
                }
                
                // ナビゲーション（最下部）
                VStack {
                    Spacer()
                    footerView
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showingAirConditioner) {
            AirConditionerView()
        }
    }
    
    // MARK: - ヘッダー
    private var headerView: some View {
        HStack {
            // トヨタロゴ（赤色の円で代用）
            Circle()
                .fill(Color.red)
                .frame(width: 30, height: 30)
                .overlay(
                    Text("T")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                )
            
            Spacer()
            
            // 車両名
            Text("ハリアー ハイブリッド")
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Spacer()
            
            // ハンバーガーメニューボタン
            Button(action: {
                // メニュー処理
            }) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color(red: 0.172, green: 0.172, blue: 0.18)) // #2C2C2E
    }
    
    // MARK: - メイン車両表示エリア
    private var carImageView: some View {
        ZStack {
            // ダークグレーのグラデーション背景
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.172, green: 0.172, blue: 0.18),
                    Color(red: 0.1, green: 0.1, blue: 0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 250)
            
            // 車両画像（システムアイコンで代用）
            Image(systemName: "car.side.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 150)
                .foregroundColor(.white)
            
            // 車両情報ボタン（右下）
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // 車両情報処理
                    }) {
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .frame(width: 30, height: 30)
                            .background(Color.black.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(.trailing, 20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    // MARK: - 車両ステータス情報エリア
    private var vehicleInfoCard: some View {
        VStack(spacing: 15) {
            // 3列レイアウトのステータス情報
            HStack {
                // 航続可能距離（左列）
                VStack(alignment: .leading, spacing: 5) {
                    Text("航続可能距離")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                    Text("146km")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // 給油情報（中央列）
                VStack(spacing: 5) {
                    Image(systemName: "fuelpump.fill")
                        .foregroundColor(Color(red: 0, green: 0.478, blue: 1)) // #007AFF
                        .font(.system(size: 16))
                    Text("23")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // 総走行距離（右列）
                VStack(alignment: .trailing, spacing: 5) {
                    Text("総走行距離")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.557, green: 0.557, blue: 0.576)) // #8E8E93
                    Text("6,395km")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
            // クルマの情報ボタン
            Button(action: {
                // 車両情報詳細処理
            }) {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    Text("クルマの情報")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(Color.clear)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    // MARK: - 警告・通知エリア
    private var alertNotificationArea: some View {
        Button(action: {
            // オートアラーム設定処理
        }) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                
                Text("オートアラームがOFFになっています")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color(red: 1, green: 0.549, blue: 0)) // #FF8C00
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 20)
    }
    
    // MARK: - 操作ボタンエリア
    private var functionButtonsView: some View {
        HStack(spacing: 30) {
            // ハザードボタン（左）
            circularButton(
                icon: "exclamationmark.triangle.fill",
                title: "ハザード",
                iconColor: Color(red: 1, green: 0.8, blue: 0.01) // #FFCC02
            ) {
                // ハザード処理
            }
            
            // エアコンボタン（中央）
            circularButton(
                icon: "fan.fill",
                title: "エアコン",
                iconColor: .white
            ) {
                showingAirConditioner = true
            }
            
            // カーファインダーボタン（右）
            circularButton(
                icon: "car.fill",
                title: "カーファインダー",
                iconColor: .white
            ) {
                // カーファインダー処理
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - リモートサービスエリア
    private var remoteServiceArea: some View {
        VStack(spacing: 15) {
            HStack {
                Text("リモートサービス")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            
            HStack(spacing: 40) {
                // クルマアイコン（左）
                VStack(spacing: 8) {
                    Button(action: {
                        // クルマ処理
                    }) {
                        Image(systemName: "car.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(red: 1, green: 0.231, blue: 0.188)) // #FF3B30
                    }
                    Text("クルマ")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                
                // お知らせアイコン（右）
                VStack(spacing: 8) {
                    Button(action: {
                        // お知らせ処理
                    }) {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    Text("お知らせ")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    // MARK: - フッター（ホームインジケーター）
    private var footerView: some View {
        VStack {
            Rectangle()
                .fill(.white)
                .frame(width: 100, height: 3)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .padding(.vertical, 15)
        }
        .frame(height: 30)
        .background(Color.black)
    }
    
    // MARK: - ヘルパーメソッド
    private func circularButton(icon: String, title: String, iconColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(Color(red: 0.235, green: 0.235, blue: 0.243)) // #3C3C3E
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 24))
                            .foregroundColor(iconColor)
                    )
                
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
        }
    }
    

}

#Preview {
    ContentView()
}
