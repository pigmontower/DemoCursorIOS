//
//  ContentView.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 背景色（ダークテーマ）
                Color(red: 0.11, green: 0.11, blue: 0.12)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // アプリヘッダー
                    headerView
                    
                    // 車両画像表示エリア
                    carImageView
                    
                    // 車両ステータス情報
                    carStatusView
                    
                    // 車両情報ボタン
                    carInfoButton
                    
                    // 警告メッセージ
                    warningMessage
                    
                    // リモートサービス
                    remoteServicesView
                    
                    Spacer()
                    
                    // ボトムナビゲーション
                    bottomNavigationView
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - アプリヘッダー
    private var headerView: some View {
        HStack {
            // トヨタロゴ
            Circle()
                .fill(Color.red)
                .frame(width: 40, height: 40)
                .overlay(
                    Text("T")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            // 車種選択ボタン
            Button(action: {}) {
                HStack {
                    Text("ハリアー ハイブリッド")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            // ハンバーガーメニュー
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(height: 56)
    }
    
    // MARK: - 車両画像表示エリア
    private var carImageView: some View {
        ZStack {
            // 車両画像のプレースホルダー
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 250)
                .overlay(
                    VStack {
                        Image(systemName: "car")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.7))
                        Text("車両画像")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                )
            
            // 画像ギャラリーアイコン
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - 車両ステータス情報
    private var carStatusView: some View {
        HStack(spacing: 20) {
            // 航続可能距離
            VStack {
                Text("航続可能距離")
                    .font(.caption)
                    .foregroundColor(.white)
                Text("146km")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // 燃料ゲージ
            VStack {
                ZStack {
                    // 半円形ゲージ
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.white.opacity(0.3), lineWidth: 8)
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(180))
                    
                    // 燃料インジケーター
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color.white, lineWidth: 8)
                        .frame(width: 60, height: 60)
                        .rotationEffect(.degrees(180))
                    
                    // 燃料ポンプアイコン
                    Image(systemName: "fuelpump")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                HStack {
                    Text("E")
                        .font(.caption)
                        .foregroundColor(.white)
                    Spacer()
                    Text("F")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(width: 60)
            }
            
            Spacer()
            
            // 総走行距離
            VStack {
                Text("総走行距離")
                    .font(.caption)
                    .foregroundColor(.white)
                Text("6,395km")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
    
    // MARK: - 車両情報ボタン
    private var carInfoButton: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                Text("① クルマの情報")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.3))
            .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    // MARK: - 警告メッセージ
    private var warningMessage: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.yellow)
                Text("オートアラームがOFFになっています")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.2))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    // MARK: - リモートサービス
    private var remoteServicesView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("リモートサービス")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
            
            HStack(spacing: 40) {
                // ハザードボタン
                VStack {
                    Button(action: {}) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    Text("ハザード")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                // エアコンボタン
                VStack {
                    Button(action: {}) {
                        Image(systemName: "fan")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    Text("エアコン")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                // カーファインダーボタン
                VStack {
                    Button(action: {}) {
                        Image(systemName: "target")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    Text("カーファインダー")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 20)
    }
    
    // MARK: - ボトムナビゲーション
    private var bottomNavigationView: some View {
        HStack {
            // クルマタブ（アクティブ）
            VStack {
                Image(systemName: "car")
                    .font(.title2)
                    .foregroundColor(.red)
                Text("クルマ")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity)
            
            // お知らせタブ（非アクティブ）
            VStack {
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("お知らせ")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 8)
        .background(Color(red: 0.11, green: 0.11, blue: 0.12))
    }
}

#Preview {
    ContentView()
}