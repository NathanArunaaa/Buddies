//
//  BuddiesWidgetLiveActivity.swift
//  BuddiesWidget
//
//  Created by Nathan Aruna on 2024-11-27.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BuddiesWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BuddiesWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BuddiesWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension BuddiesWidgetAttributes {
    fileprivate static var preview: BuddiesWidgetAttributes {
        BuddiesWidgetAttributes(name: "World")
    }
}

extension BuddiesWidgetAttributes.ContentState {
    fileprivate static var smiley: BuddiesWidgetAttributes.ContentState {
        BuddiesWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BuddiesWidgetAttributes.ContentState {
         BuddiesWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BuddiesWidgetAttributes.preview) {
   BuddiesWidgetLiveActivity()
} contentStates: {
    BuddiesWidgetAttributes.ContentState.smiley
    BuddiesWidgetAttributes.ContentState.starEyes
}
