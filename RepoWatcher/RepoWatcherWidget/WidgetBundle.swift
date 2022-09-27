//
//  WidgetBundle.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jonathan Yataco on 9/27/22.
//

import SwiftUI
import WidgetKit

@main
struct RepoWatcherWidgets: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
