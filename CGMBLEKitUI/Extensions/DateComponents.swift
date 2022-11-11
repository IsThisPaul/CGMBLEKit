//
//  DateComponents.swift
//  CGMBLEKitUI
//
//  Created by Pete Schwamb on 10/23/22.
//  Copyright © 2022 LoopKit Authors. All rights reserved.
//

import Foundation

extension DateComponents {

    public var pairs: [(String, String)] {
        var result = [(String, String)]()
        if let day = day, day > 0 {
            appendDay(&result, day)
            if let hour = hour, day < 10, hour > 0 {
                appendHour(&result, hour)
            }
        } else {
            if let hour = hour, hour > 0 {
                appendHour(&result, hour)
            }
            if let minute = minute, (hour ?? 0) < 10 {
                appendMinute(&result, minute)
            }
            if let second = second {
                appendSecond(&result, second)
            }
        }
        return result
    }

    private func appendDay(_ result: inout [(String, String)], _ day: Int) {
        result.append(("\(day)", day > 1 ? LocalizedString("days", comment: "Unit of time for days (plural)") : LocalizedString("day", comment: "Unit of time for day (singular)")))
    }

    private func appendHour(_ result: inout [(String, String)], _ hour: Int) {
        result.append(("\(hour)", hour > 1 ? LocalizedString("hrs", comment: "Unit of time for hours (plural, abbreviated)") : LocalizedString("hr", comment: "Unit of time for hour (singular, abbreviated)")))
    }

    private func appendMinute(_ result: inout [(String, String)], _ minute: Int) {
        result.append(("\(minute)", LocalizedString("min", comment: "Unit of time for minutes (both singular and plural, abbreviated)")))
    }

    private func appendSecond(_ result: inout [(String, String)], _ second: Int) {
        result.append(("\(second)", LocalizedString("sec", comment: "Unit of time for minutes (both singular and plural, abbreviated)")))
    }
}

