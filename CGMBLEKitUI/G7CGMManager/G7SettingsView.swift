//
//  G7SettingsView.swift
//  CGMBLEKitUI
//
//  Created by Pete Schwamb on 9/25/22.
//  Copyright © 2022 LoopKit Authors. All rights reserved.
//

import Foundation
import SwiftUI

struct G7SettingsView: View {
    var didFinish: (() -> Void)
    var deleteCGM: (() -> Void)

    @ObservedObject var viewModel: G7SettingsViewModel

    init(didFinish: @escaping () -> Void, deleteCGM: @escaping () -> Void, viewModel: G7SettingsViewModel) {
        self.didFinish = didFinish
        self.deleteCGM = deleteCGM
        self.viewModel = viewModel
    }

    private var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateStyle = .short
        formatter.timeStyle = .short

        return formatter
    }()

    var body: some View {
        List {
            Section() {
                VStack {
                    headerImage
                }
            }
            if let name = viewModel.sensorName {
                HStack {
                    Text("BLE Name")
                    Spacer()
                    Text(name)
                }
            }
            if let activatedAt = viewModel.activatedAt {
                HStack {
                    Text("Activated At")
                    Spacer()
                    Text(timeFormatter.string(from: activatedAt))
                }
            }
            if viewModel.scanning {
                HStack {
                    Text("Scanning")
                    ProgressView()
                }
            }
            Section () {
                Button("Delete CGM", action: {
                    self.deleteCGM()
                })
            }
        }
        .insetGroupedListStyle()
        .navigationBarItems(trailing: doneButton)
        .navigationBarTitle(LocalizedString("Dexcom G7", comment: "Navigation bar title for G7SettingsView"))
    }

    var headerImage: some View {
        VStack(alignment: .center) {
            Image(frameworkImage: "g7")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .frame(height: 150)
                .padding(.horizontal)
        }.frame(maxWidth: .infinity)
    }

    private var doneButton: some View {
        Button("Done", action: {
            self.didFinish()
        })
    }

}
