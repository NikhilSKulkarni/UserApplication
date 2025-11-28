//
//  UsersAppApp.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//

import SwiftUI

@main
struct UsersAppApp: App {
    var body: some Scene {
        WindowGroup {
            UserView(viewModel: UserViewModel(userUseCase: GetUsersUseCase(userRepository: UserRepositoryImpl(apiService: APIService()))))
        }
    }
}
