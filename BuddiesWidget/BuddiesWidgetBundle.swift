//
//  BuddiesWidgetBundle.swift
//  BuddiesWidget
//
//  Created by Nathan Aruna on 2024-11-27.
//

import WidgetKit
import SwiftUI

@main
struct BuddiesWidgetBundle: WidgetBundle {
    var body: some Widget {
        BuddiesWidget()
        BuddiesWidgetControl()
        BuddiesWidgetLiveActivity()
    }
}
