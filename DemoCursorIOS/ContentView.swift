//
//  ContentView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // ヘッダーセクション
                    HeaderSection()
                    
                    // 車両画像セクション
                    VehicleImageSection()
                    
                    // 車両情報セクション
                    VehicleInfoSection()
                    
                    // 通知セクション
                    NotificationSection()
                    
                    // アクションボタンセクション
                    ActionButtonsSection()
                    
                    // フッターセクション
                    FooterSection()
                }
            }
            .background(Color(hex: 0x1C1C1E))
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

// MARK: - ヘッダーセクション
struct HeaderSection: View {
    var body: some View {
        HStack {
            // ブランドロゴ
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.red)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "car.side.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                )
            
            Spacer()
            
            // 車種表示
            Text("ハリアー ハイブリッド")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            // メニューボタン
            Button(action: {
                // メニュー表示処理
            }) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(height: 60)
        .background(Color(hex: 0x2C2C2E))
    }
}

// MARK: - 車両画像セクション
struct VehicleImageSection: View {
    var body: some View {
        ZStack {
            // グラデーション背景
            LinearGradient(
                colors: [Color(hex: 0x1C1C1E), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 240)
            
            VStack {
                Spacer()
                
                // 車両画像プレースホルダー
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 320, height: 180)
                        .cornerRadius(12)
                    
                    Image(systemName: "car.side.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.7))
                    
                    // 拡大ボタン
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                // 画像拡大処理
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 32, height: 32)
                                    
                                    Image(systemName: "plus.magnifyingglass")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                            }
                            .padding(.bottom, 8)
                            .padding(.trailing, 8)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - 車両情報セクション
struct VehicleInfoSection: View {
    var body: some View {
        HStack {
            // 燃費情報
            VStack(alignment: .leading, spacing: 4) {
                Text("給油時燃費記録")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: 0x8E8E93))
                
                Text("146km")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            
            // 給油アイコン
            Image(systemName: "fuelpump.fill")
                .foregroundColor(.white)
                .font(.system(size: 24))
                .padding(.leading, 8)
            
            Spacer()
            
            // 総走行距離情報
            VStack(alignment: .trailing, spacing: 4) {
                Text("総走行距離")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: 0x8E8E93))
                
                Text("6,395km")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(16)
        .frame(height: 80)
        .background(Color(hex: 0x1C1C1E))
    }
}

// MARK: - 通知セクション
struct NotificationSection: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                // 警告アイコン
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(Color(hex: 0xFF9500))
                    .font(.system(size: 20))
                
                // 通知テキスト
                Text("オートアラームがOFFになっています")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                
                Spacer()
                
                // 詳細ボタン
                Button(action: {
                    // 詳細画面への遷移
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: 0x8E8E93))
                        .font(.system(size: 16))
                }
            }
            .padding(12)
            .background(Color(hex: 0xFFCC00).opacity(0.2))
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color(hex: 0x1C1C1E))
    }
}

// MARK: - アクションボタンセクション
struct ActionButtonsSection: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                // ハザードボタン
                ActionButton(
                    icon: "exclamationmark.triangle.fill",
                    label: "ハザード",
                    action: {
                        // ハザードランプ切り替え
                    }
                )
                
                // エアコンボタン
                ActionButton(
                    icon: "wind",
                    label: "エアコン",
                    action: {
                        // エアコン制御画面へ遷移
                    }
                )
                
                // カーファインダーボタン
                ActionButton(
                    icon: "location.circle.fill",
                    label: "カーファインダー",
                    action: {
                        // 車両位置確認機能実行
                    }
                )
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(Color(hex: 0x1C1C1E))
    }
}

// アクションボタンコンポーネント
struct ActionButton: View {
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color(hex: 0x2C2C2E))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .stroke(Color(hex: 0x3A3A3C), lineWidth: 1)
                        )
                    
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
            }
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white)
        }
    }
}

// MARK: - フッターセクション
struct FooterSection: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("リモートサービス")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
            
            HStack(spacing: 24) {
                // 車両アイコン
                Image(systemName: "car.side.fill")
                    .foregroundColor(Color(hex: 0xFF3B30))
                    .font(.system(size: 24))
                
                // メールアイコン
                Image(systemName: "envelope.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                
                // お知らせベルアイコン
                Image(systemName: "bell.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
        }
        .padding(16)
        .frame(height: 80)
        .background(Color(hex: 0x1C1C1E))
    }
}

// MARK: - カラー拡張
extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

#Preview {
    ContentView()
}
