//
//  DemoCursorIOSUITests.swift
//  DemoCursorIOSUITests
//
//  Created by 山本真寛 on 2025/08/24.
//

import XCTest

final class DemoCursorIOSUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        // エアコン画面に遷移（ContentViewからの遷移を想定）
        navigateToAirConditionerScreen()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - 1.2.1 共通要素テスト
    
    /// UI001: ヘッダー存在確認
    @MainActor
    func testUI001_HeaderExists() throws {
        XCTAssertTrue(waitForHeaderToAppear(), "ヘッダーが表示されている")
    }
    
    /// UI002: 戻るボタン存在確認
    @MainActor
    func testUI002_BackButtonExists() throws {
        XCTAssertTrue(waitForBackButton(), "戻るボタンが表示されている")
    }
    
    /// UI003: タイトル表示確認
    @MainActor
    func testUI003_TitleDisplay() throws {
        XCTAssertTrue(app.staticTexts["エアコン"].exists, "「エアコン」が表示されている")
    }
    
    /// UI004: ヘルプボタン存在確認
    @MainActor
    func testUI004_HelpButtonExists() throws {
        XCTAssertTrue(waitForHelpButton(), "ヘルプボタンが表示されている")
    }
    
    // MARK: - 1.2.2 初期表示状態UI確認
    
    /// UI005: 設定確認メッセージ表示
    @MainActor
    func testUI005_SettingConfirmationMessage() throws {
        XCTAssertTrue(app.staticTexts["下記の設定でエアコンを起動します。"].exists, "メッセージが表示されている")
    }
    
    /// UI006: 確認問いかけ表示
    @MainActor
    func testUI006_ConfirmationQuestion() throws {
        XCTAssertTrue(app.staticTexts["よろしいですか？"].exists, "メッセージが表示されている")
    }
    
    /// UI007: 設定タイトル表示
    @MainActor
    func testUI007_SettingTitle() throws {
        XCTAssertTrue(app.staticTexts["エアコンの設定"].exists, "タイトルが表示されている")
    }
    
    /// UI008: 変更リンク表示
    @MainActor
    func testUI008_ChangeLink() throws {
        XCTAssertTrue(app.staticTexts["変更する"].exists, "リンクが表示されている")
    }
    
    /// UI009: 起動時間ラベル表示
    @MainActor
    func testUI009_StartTimeLabel() throws {
        XCTAssertTrue(app.staticTexts["起動時間"].exists, "ラベルが表示されている")
    }
    
    /// UI010: 起動時間数値表示
    @MainActor
    func testUI010_StartTimeValue() throws {
        XCTAssertTrue(app.staticTexts["10"].exists, "数値が表示されている")
    }
    
    /// UI011: 起動時間単位表示
    @MainActor
    func testUI011_StartTimeUnit() throws {
        XCTAssertTrue(app.staticTexts["分間"].exists, "単位が表示されている")
    }
    
    /// UI012: 実行ボタン表示
    @MainActor
    func testUI012_ExecuteButton() throws {
        XCTAssertTrue(app.buttons["この設定で起動する"].exists, "ボタンが表示されている")
    }
    
    // MARK: - 1.2.3 完了状態UI確認
    
    /// UI013: 停止までテキスト表示
    @MainActor
    func testUI013_StopUntilText() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["エアコン停止まで"].exists, "テキストが表示されている")
    }
    
    /// UI014: カウントダウン数値表示
    @MainActor
    func testUI014_CountdownValue() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["9"].exists, "数値が表示されている")
    }
    
    /// UI015: カウントダウン単位表示
    @MainActor
    func testUI015_CountdownUnit() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["分"].exists, "単位が表示されている")
    }
    
    /// UI016: 起動時間数値表示（完了時）
    @MainActor
    func testUI016_StartTimeValueCompleted() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["10"].exists, "数値が表示されている")
    }
    
    /// UI017: 停止ボタン表示（赤）
    @MainActor
    func testUI017_StopButton() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.buttons["停止する"].exists, "ボタンが表示されている")
    }
    
    // MARK: - 1.2.4 通知設定エリアUI確認
    
    /// UI018: 通知設定タイトル表示
    @MainActor
    func testUI018_NotificationSettingTitle() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["通知設定"].exists, "タイトルが表示されている")
    }
    
    /// UI019: 通知説明文表示
    @MainActor
    func testUI019_NotificationDescription() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["クルマの操作関連通知をONにすると、リモート操作完了時にお知らせします。"].exists, "説明文が表示されている")
    }
    
    /// UI020: 設定アイコン表示
    @MainActor
    func testUI020_SettingIcon() throws {
        startAirConditionerAndWait()
        let settingIcon = app.buttons.containing(NSPredicate(format: "label CONTAINS 'gearshape'")).firstMatch
        XCTAssertTrue(settingIcon.exists, "アイコンが表示されている")
    }
    
    /// UI021: 設定ボタンテキスト表示
    @MainActor
    func testUI021_SettingButtonText() throws {
        startAirConditionerAndWait()
        XCTAssertTrue(app.staticTexts["アプリの通知を設定する"].exists, "テキストが表示されている")
    }
    
    // MARK: - ヘルパーメソッド：ナビゲーション
    
    /// エアコン画面への遷移
    private func navigateToAirConditionerScreen() {
        // ContentViewからエアコン画面への遷移ボタンをタップ
        // 具体的な遷移方法は実際のContentViewの実装に依存
        if app.buttons["エアコン"].exists {
            app.buttons["エアコン"].tap()
        }
        
        // エアコン画面のタイトルが表示されるまで待機
        _ = app.staticTexts["エアコン"].waitForExistence(timeout: 5)
    }
    
    // MARK: - ヘルパーメソッド：基本操作
    
    /// 起動ボタンをタップして完了状態まで待機
    private func startAirConditionerAndWait() {
        XCTAssertTrue(waitForStartButton(), "起動ボタンが表示される")
        XCTAssertTrue(app.buttons["この設定で起動する"].isEnabled, "起動ボタンが有効である")
        
        app.buttons["この設定で起動する"].tap()
        XCTAssertTrue(waitForRunningStatus(), "動作中状態になる")
    }
    
    // MARK: - ヘルパーメソッド：待機処理
    
    /// ヘッダーの出現を待機
    @discardableResult
    private func waitForHeaderToAppear(timeout: TimeInterval = 5) -> Bool {
        // ヘッダーの代表的な要素（タイトル）で判定
        return app.staticTexts["エアコン"].waitForExistence(timeout: timeout)
    }
    
    /// 戻るボタンの出現を待機
    @discardableResult
    private func waitForBackButton(timeout: TimeInterval = 5) -> Bool {
        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'chevron.left'")).firstMatch
        return backButton.waitForExistence(timeout: timeout)
    }
    
    /// ヘルプボタンの出現を待機
    @discardableResult
    private func waitForHelpButton(timeout: TimeInterval = 5) -> Bool {
        let helpButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'questionmark.circle'")).firstMatch
        return helpButton.waitForExistence(timeout: timeout)
    }
    
    /// 起動ボタンの出現を待機
    @discardableResult
    private func waitForStartButton(timeout: TimeInterval = 5) -> Bool {
        return app.buttons["この設定で起動する"].waitForExistence(timeout: timeout)
    }
    
    /// 動作中ステータスの出現を待機
    @discardableResult
    private func waitForRunningStatus(timeout: TimeInterval = 5) -> Bool {
        return app.staticTexts["この設定で動作中"].exists || 
               app.staticTexts["エアコン停止まで"].waitForExistence(timeout: timeout)
    }

    // MARK: - パフォーマンステスト（既存）
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
