//
//  ContentView.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//

import SwiftUI

struct UserView: View {
    @StateObject private var viewModel: UserViewModel
    init(viewModel: UserViewModel){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    VStack(alignment: .leading) {
                        List(viewModel.users) { user in
                            NavigationLink(value: user ) {
                                //User Row view
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .foregroundColor(.primary)
                                        .font(.headline)
                                    Text(user.username)
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("User List")
            .navigationDestination(for: User.self) { user in
               UserDetailView(selectedUser: user)
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
   
}

