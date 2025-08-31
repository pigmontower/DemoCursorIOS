//
//  AirConditionerViewModel.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import Foundation
import SwiftUI

// MARK: - エアコン画面の状態
enum AirConditionerState {
    case initial      // 初期表示
    case requesting   // リクエスト中
    case completed    // 完了
}

// MARK: - エアコン画面ViewModel
class AirConditionerViewModel: ObservableObject {
    @Published var currentState: AirConditionerState = .initial
    @Published var remainingTime: Int = 10 // 分
    @Published var isTimerActive = false
    
    private var timer: Timer?
    
    // MARK: - 初期化
    init() {
        // 初期化処理
    }
    
    // MARK: - エアコン起動処理
    func startAirConditioner() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .requesting
        }
        
        // 3-5秒後に完了状態に遷移
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.currentState = .completed
                self.startTimer()
            }
        }
    }
    
    // MARK: - エアコン停止処理
    func stopAirConditioner() {
        stopTimer()
        withAnimation(.easeInOut(duration: 0.3)) {
            currentState = .initial
            remainingTime = 10
        }
    }
    
    // MARK: - タイマー機能
    private func startTimer() {
        isTimerActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            if self.remainingTime > 0 && self.isTimerActive {
                self.remainingTime -= 1
            } else {
                self.stopTimer()
                if self.remainingTime <= 0 {
                    // 自動停止
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.currentState = .initial
                        self.remainingTime = 10
                    }
                }
            }
        }
    }
    
    private func stopTimer() {
        isTimerActive = false
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - クリーンアップ
    func onDisappear() {
        stopTimer()
    }
}
