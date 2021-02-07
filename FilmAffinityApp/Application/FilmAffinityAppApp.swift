//
//  FilmAffinityAppApp.swift
//  FilmAffinityApp
//
//  Created by Jmorgaz on 10/1/21.
//

import SwiftUI

@main
struct FilmAffinityAppApp: App {
    var body: some Scene {
        WindowGroup {
            DetailView(viewModel: DetailViewModel())
        }
    }
}
