//
//  UserDetailView.swift
//  UsersApp
//

import SwiftUI

struct UserDetailView: View {
    var selectedUser: User
    var body: some View {
        VStack(spacing: 16) {
            // MARK: - Details
            VStack(alignment: .leading, spacing: 12) {
                Text(selectedUser.name)
                    .font(.title2)
                    .bold()
                Text(selectedUser.username)
                    .font(.body)
                    .foregroundColor(.secondary)
                Text(selectedUser.email)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.vertical)
        
    }
}

#Preview {
   
}
