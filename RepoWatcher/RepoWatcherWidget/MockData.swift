//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Jonathan Yataco on 9/27/22.
//

import Foundation

struct MockData {
    static let repoOne = Repository(name: "Repository 1",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 65,
                                        watchers: 123,
                                        openIssues: 55,
                                        pushedAt: "2021-08-09T18:19:30Z",
                                        avatarData: Data(),
                                        contributors: [Contributor(login: "Sean Allen", avatarUrl: "", contributions: 42, avatarData: Data()),
                                                       Contributor(login: "Michael Jordan", avatarUrl: "", contributions: 23, avatarData: Data()),
                                                       Contributor(login: "Steph Curry", avatarUrl: "", contributions: 30, avatarData: Data()),
                                                       Contributor(login: "Lebron James", avatarUrl: "", contributions: 6, avatarData: Data())
                                                      ])
    
    static let repoTwo = Repository(name: "Repository 2",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 65,
                                        watchers: 123,
                                        openIssues: 55,
                                        pushedAt: "2021-08-09T18:19:30Z",
                                        avatarData: Data())
}
