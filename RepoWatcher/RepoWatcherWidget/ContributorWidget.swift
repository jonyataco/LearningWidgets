//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jonathan Yataco on 9/27/22.
//

import WidgetKit
import SwiftUI

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: .now, repo: MockData.repoOne)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: .now, repo: MockData.repoOne)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200)
            
            do {
                // Get Repo
                let repoToShow = RepoURL.swiftNews
                var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                // Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + "/contributors")
                
                // Filter to just top 4 contributors
                var topFour = Array(contributors.prefix(4))
                
                // Download top 4 avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
                
                // Create Entry & Timeline
                let entry = ContributorEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct ContributorEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}


struct ContributorEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: ContributorEntry
    
    var body: some View {
        VStack {
            RepoMediumView(repo: entry.repo)
            ContributorMediumView(repo: entry.repo)
        }
    }
}

struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            ContributorEntryView(entry: entry)
        }
        .configurationDisplayName("Contributors")
        .description("Keep track of a repository's top contributors")
        .supportedFamilies([.systemLarge])
    }
}

struct ContributorWidget_Previews: PreviewProvider {
    static var previews: some View {
        ContributorEntryView(entry: ContributorEntry(date: Date(), repo: MockData.repoOne))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
