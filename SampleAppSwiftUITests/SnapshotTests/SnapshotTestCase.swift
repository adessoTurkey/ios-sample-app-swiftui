//
//  SnapshotTestCase.swift
//  SampleAppSwiftUITests
//
//  Created by Yildirim, Alper on 25.07.2023.
//

import PreviewSnapshots
import PreviewSnapshotsTesting
@testable import SampleAppSwiftUI
import SwiftUI
import XCTest

class SnapshotTestCase: XCTestCase {
    enum SnapshotFormat {
        case image
//        case file
//        case line
    }

    // swiftlint:disable large_tuple
    typealias SnapshotArguments = (recording: Bool,
                                   timeOut: TimeInterval?,
                                   file: StaticString,
                                   testName: String,
                                   layout: SwiftUISnapshotLayout,
                                   line: UInt)
    // swiftlint:enable large_tuple

    var recordMode: Bool {
        get { isRecording }
        set { isRecording = newValue }
    }

    var presicion: Float = 0.98
    var layoutDevice: SwiftUISnapshotLayout = .device(config: .iPhone13)

    override func setUp() {
        super.setUp()
        UIView.setAnimationsEnabled(false)
    }

    func verifyView<State>(_ previewSnapshot: PreviewSnapshots<State>,
                           dispatchAsyncOnMainThread: Bool = false,
                           as snapshotting: SnapshotFormat = .image,
                           using layout: SwiftUISnapshotLayout = .sizeThatFits,
                           record recording: Bool = false,
                           file: StaticString = #file,
                           timeOut: TimeInterval? = nil,
                           testName: String = #function,
                           line: UInt = #line) {
        if dispatchAsyncOnMainThread {
            dispatchAsyncAndWait {
                self.assertSnap(previewSnapshot, as: snapshotting, with: (recording: recording, timeOut: timeOut, file: file, testName: testName, layout: layout, line: line))
            }
        } else {
            assertSnap(previewSnapshot, as: snapshotting, with: (recording: recording, timeOut: timeOut, file: file, testName: testName, layout: layout, line: line))
        }
    }

    private func assertSnap<State>(_ previewSnapshot: PreviewSnapshots<State>,
                                   as snapshotting: SnapshotFormat = .image,
                                   with arguments: SnapshotArguments) {
        switch snapshotting {
            case .image:
                guard let timeOutDuration = arguments.timeOut else {
                    assertImage(previewSnapshot, with: arguments)
                    return
                }
                asssertImageWithDuration(previewSnapshot, timeOut: timeOutDuration, with: arguments)
        }
    }

    private func assertImage<State>(_ previewSnapshot: PreviewSnapshots<State>,
                                    with arguments: SnapshotArguments) {
        previewSnapshot.assertSnapshots(as: .image(precision: presicion, layout: arguments.layout), record: arguments.recording)
    }

    private func asssertImageWithDuration<State>(_ previewSnapshot: PreviewSnapshots<State>,
                                                 timeOut: TimeInterval,
                                                 with arguments: SnapshotArguments) {
        previewSnapshot.assertSnapshots(as: .wait(for: timeOut, on: .image(precision: presicion, layout: arguments.layout)), record: arguments.recording)
    }

}
