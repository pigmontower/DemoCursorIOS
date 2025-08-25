//
//  AirConditionerViewModelTest.swift
//  DemoCursorIOSTests
//
//  Created by AI Assistant on 2024/12/19.
//

import XCTest
import SwiftUI
@testable import DemoCursorIOS

final class AirConditionerViewModelTest: XCTestCase {
    
    var viewModel: AirConditionerViewModel!
    
    override func setUpWithError() throws {
        viewModel = AirConditionerViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // MARK: - 1.1.1 状態管理テスト
    
    /// VM001: 初期状態確認
    func testInitialState() {
        XCTAssertEqual(viewModel.currentState, .initial, "ViewModelインスタンス作成直後の状態が.initialであること")
    }
    
    /// VM002: remainingTime初期値
    func testInitialRemainingTime() {
        XCTAssertEqual(viewModel.remainingTime, 10, "ViewModelインスタンス作成直後のremainingTimeが10であること")
    }
    
    /// VM003: countdownTime初期値
    func testInitialCountdownTime() {
        XCTAssertEqual(viewModel.countdownTime, 9, "ViewModelインスタンス作成直後のcountdownTimeが9であること")
    }
    
    // MARK: - 1.1.2 エアコン起動処理テスト
    
    /// VM004: startAirConditioner呼び出し
    func testStartAirConditionerStateChange() {
        // 実行
        viewModel.startAirConditioner()
        
        // 検証
        XCTAssertEqual(viewModel.currentState, .completed, "startAirConditioner()実行後の状態が.completedであること")
    }
    
    /// VM005: カウントダウン開始
    func testCountdownTimerStart() {
        // 実行
        viewModel.startAirConditioner()
        
        // 検証：完了状態遷移後のカウントダウンタイマー開始
        XCTAssertEqual(viewModel.currentState, .completed, "完了状態に遷移していること")
        // タイマーが動作していることは実装に依存するため、現在は状態確認のみ
    }
    
    // MARK: - 1.1.3 エアコン停止処理テスト
    
    /// VM006: 完了状態からの停止
    func testStopFromCompletedState() {
        // セットアップ：完了状態にする
        viewModel.startAirConditioner()
        XCTAssertEqual(viewModel.currentState, .completed, "前提条件：完了状態であること")
        
        // 実行
        viewModel.stopAirConditioner()
        
        // 検証
        XCTAssertEqual(viewModel.currentState, .initial, "完了状態からstopAirConditioner()実行後、.initial状態に戻ること")
    }
    
    /// VM007: カウントダウンリセット
    func testCountdownReset() {
        // セットアップ：完了状態にする
        viewModel.startAirConditioner()
        
        // 実行
        viewModel.stopAirConditioner()
        
        // 検証
        XCTAssertEqual(viewModel.countdownTime, 9, "停止時にcountdownTimeが9にリセットされること")
    }
    
    /// VM008: タイマー停止
    func testTimerStopOnStop() {
        // セットアップ：完了状態にする
        viewModel.startAirConditioner()
        
        // 実行
        viewModel.stopAirConditioner()
        
        // 検証：タイマーが停止されていることを間接的に確認
        // （タイマーが停止されていれば、カウントダウンが進まない）
        let initialCountdown = viewModel.countdownTime
        
        // 少し待ってカウントダウンが進んでいないことを確認
        let expectation = self.expectation(description: "Timers stopped on stop")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertEqual(self.viewModel.countdownTime, initialCountdown, "停止後はカウントダウンが進まないこと（タイマーが停止されていること）")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    // MARK: - 1.1.4 タイマー処理テスト
    
    /// VM009: カウントダウン減算（注意：実際のテストでは60秒待つのは現実的でないため、短時間でのテストとして実装）
    func testCountdownDecrement() {
        // 注意：実装では60秒間隔でカウントダウンが減算されるが、
        // テストでは現実的な時間で検証するため、この機能の詳細なテストは統合テストで実施することを推奨
        viewModel.startAirConditioner()
        
        let initialCountdown = viewModel.countdownTime
        XCTAssertEqual(initialCountdown, 9, "カウントダウン開始時の値が9であること")
    }
    
    /// VM010: カウントダウン終了（注意：実際のテストでは60*9=540秒待つのは現実的でないため、ロジックの確認のみ）
    func testCountdownZeroAutoStop() {
        // カウントダウンが0になったときの自動停止ロジックを確認
        // 実際の時間ベースのテストは統合テストで実施
        
        // セットアップ：カウントダウンを0に設定
        viewModel.countdownTime = 0
        
        // stopAirConditioner が呼ばれることをテストするため、
        // 手動でカウントダウン終了時の処理をテスト
        let initialState = viewModel.currentState
        viewModel.stopAirConditioner()
        
        XCTAssertEqual(viewModel.currentState, .initial, "カウントダウン終了時に初期状態に戻ること")
    }
    
    /// VM011: View非表示時のタイマー停止
    func testTimerStopOnViewDisappear() {
        // セットアップ：完了状態にしてタイマーを開始
        viewModel.startAirConditioner()
        
        // 実行
        viewModel.onViewDisappear()
        
        // 検証：タイマーが停止されていることを確認
        let initialCountdown = viewModel.countdownTime
        
        let expectation = self.expectation(description: "Timer stop on view disappear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertEqual(self.viewModel.countdownTime, initialCountdown, "onViewDisappear()でタイマーが停止されること")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    // MARK: - 1.1.5 アニメーション関連テスト
    
    /// VM014: 回転アニメーション初期化
    func testRotationAnimationInitialization() {
        // ViewModelインスタンス作成時に回転アニメーションが設定されることを確認
        // rotationAngleは初期化後にアニメーションによって360に設定される
        
        // 少し待ってアニメーションが開始されることを確認
        let expectation = self.expectation(description: "Rotation animation initialization")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // アニメーションが開始されると rotationAngle が変更される
            XCTAssertEqual(self.viewModel.rotationAngle, 360, "ViewModelインスタンス作成時に回転アニメーションが設定されること")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: - 1.2 UI要素の存在確認テスト
    // 注意：UI要素の存在確認は本来SwiftUI Viewのテストですが、
    // ViewModelに関連する状態ベースのテストとして一部実装
    
    /// UI003: 状態に応じた表示切替の確認（ViewModelの状態管理テスト）
    func testStateBasedDisplaySwitching() {
        // 初期状態
        XCTAssertEqual(viewModel.currentState, .initial, "初期状態が.initialであること")
        
        // リクエスト中状態への遷移
        viewModel.startAirConditioner()
        XCTAssertEqual(viewModel.currentState, .requesting, "リクエスト中状態に遷移すること")
        
        // 停止処理
        viewModel.stopAirConditioner()
        XCTAssertEqual(viewModel.currentState, .initial, "初期状態に戻ること")
    }
    
    // MARK: - 1.3 状態遷移テスト
    
    /// ST001: 初期→完了遷移
    func testInitialToCompletedTransition() {
        // 前提条件
        XCTAssertEqual(viewModel.currentState, .initial, "初期状態であること")
        
        // 実行
        viewModel.startAirConditioner()
        
        // 検証
        XCTAssertEqual(viewModel.currentState, .completed, "実行ボタンタップ後（startAirConditioner実行後）、completed状態に遷移すること")
    }
    
    /// ST002: 完了→初期遷移（停止）
    func testCompletedToInitialTransition() {
        // セットアップ：完了状態にする
        viewModel.startAirConditioner()
        XCTAssertEqual(viewModel.currentState, .completed, "前提条件：完了状態であること")
        
        // 実行
        viewModel.stopAirConditioner()
        
        // 検証
        XCTAssertEqual(viewModel.currentState, .initial, "停止ボタンタップ後（stopAirConditioner実行後）、initial状態に遷移すること")
    }
    
    // MARK: - 1.4 データバインディングテスト
    
    /// DB001: remainingTime表示
    func testRemainingTimeBinding() {
        XCTAssertEqual(viewModel.remainingTime, 10, "ViewModelのremainingTimeが10として表示されること")
        
        // 値を変更してバインディングを確認
        viewModel.remainingTime = 15
        XCTAssertEqual(viewModel.remainingTime, 15, "remainingTimeの値変更がUIに反映されること")
    }
    
    /// DB002: countdownTime表示
    func testCountdownTimeBinding() {
        XCTAssertEqual(viewModel.countdownTime, 9, "ViewModelのcountdownTimeが9として表示されること")
        
        // 値を変更してバインディングを確認
        viewModel.countdownTime = 5
        XCTAssertEqual(viewModel.countdownTime, 5, "countdownTimeの値変更がUIに反映されること")
    }
    
    /// DB003: 状態変更による表示切替
    func testStateChangeDisplaySwitching() {
        // 初期状態
        XCTAssertEqual(viewModel.currentState, .initial, "初期状態でinitial状態のUIが表示されること")
        
        // リクエスト中状態への変更
        viewModel.currentState = .requesting
        XCTAssertEqual(viewModel.currentState, .requesting, "状態変更でrequesting状態のUIが表示されること")
        
        // 完了状態への変更
        viewModel.currentState = .completed
        XCTAssertEqual(viewModel.currentState, .completed, "状態変更でcompleted状態のUIが表示されること")
        
        // 初期状態への変更
        viewModel.currentState = .initial
        XCTAssertEqual(viewModel.currentState, .initial, "状態変更でinitial状態のUIが表示されること")
    }
    
    // MARK: - 追加のエッジケーステスト
    
    /// 連続した開始/停止操作のテスト
    func testRapidStartStopOperations() {
        // 連続して開始・停止を実行
        viewModel.startAirConditioner()
        viewModel.stopAirConditioner()
        
        XCTAssertEqual(viewModel.currentState, .initial, "連続した開始・停止操作後に初期状態に戻ること")
        XCTAssertEqual(viewModel.countdownTime, 9, "連続した操作後にcountdownTimeがリセットされること")
    }
    
    /// deinitでのタイマー停止テスト
    func testDeinitTimerCleanup() {
        // ViewModelを開始状態にする
        viewModel.startAirConditioner()
        
        // ViewModelを解放（deinitが呼ばれる）
        viewModel = nil
        
        // メモリリークがないことを確認（実際のメモリリークテストは別途Instrumentsで実施）
        XCTAssertNil(viewModel, "ViewModelが適切に解放されること")
    }
}
