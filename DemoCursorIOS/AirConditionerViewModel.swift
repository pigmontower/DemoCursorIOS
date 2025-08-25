//
//  AirConditionerViewModel.swift
//  DemoCursorIOS
//
//  Created by 山本真寛 on 2025/08/24.
//

import SwiftUI
import Foundation

// MARK: - ViewModel
class AirConditionerViewModel: ObservableObject {
    @Published var currentState: AirConditionerState = .initial
    @Published var remainingTime: Int = 10 // 起動時間（分）
    @Published var countdownTime: Int = 9  // カウントダウン時間（分）
    @Published var rotationAngle: Double = 0
    
    private var timer: Timer?
    private var requestTimer: Timer?
    
    init() {
        startRotationAnimation()
    }
    
    deinit {
        stopAllTimers()
    }
    
    // MARK: - Public Methods
    func startAirConditioner() {
        // フィードバック
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        // リクエスト中状態に変更
        withAnimation(.easeInOut(duration: 0.5)) {
            currentState = .requesting
        }
        
        // 3秒後に完了状態に自動遷移
        requestTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                self.currentState = .completed
            }
            self.startCountdown()
        }
    }
    
    func stopAirConditioner() {
        // フィードバック
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
        
        stopAllTimers()
        
        // 初期状態に戻る
        withAnimation(.easeInOut(duration: 0.5)) {
            currentState = .initial
            countdownTime = 9 // リセット
        }
    }
    
    func onViewDisappear() {
        stopAllTimers()
    }
    
    // MARK: - Private Methods
    private func startRotationAnimation() {
        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            if self.countdownTime > 0 {
                self.countdownTime -= 1
            } else {
                self.stopAirConditioner()
            }
        }
    }
    
    private func stopAllTimers() {
        timer?.invalidate()
        timer = nil
        requestTimer?.invalidate()
        requestTimer = nil
    }
}
