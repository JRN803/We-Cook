//
//  LoginView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = AuthViewModel.shared
    @ObservedObject var appViewModel = AppViewModel.shared
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(Color.primaryColor)
                    .ignoresSafeArea()
                VStack {
                    Image(systemName:"person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(.white)
                        .padding()
                    TextField("Email",text: $viewModel.user.email)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.vertical,5)
                    SecureField("Password",text: $viewModel.user.password)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    Toggle("Remember Me", isOn: $viewModel.user.remember)
                        .toggleStyle(.switch)
                        .foregroundStyle(.white)
                    Button{
                        Task {
                            do {
                                try await viewModel.loginUser()
                                appViewModel.selectedView = .recipes
                            } catch {}
                        }
                    }label: {
                        Text("Login")
                            .frame(width:100,height:30)
                            .background(.white)
                    }.clipShape(.capsule)
                    Text("Don't have an account?")
                        .foregroundStyle(.blue)
                        .onTapGesture{appViewModel.selectedView = .register}
                    Spacer()
                }
                .padding(.vertical,150)
                .padding(.horizontal, 50)
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Login")
            .toolbar(.hidden)
            .alert(item: $viewModel.alertItem) {alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
            .onAppear{appViewModel.hideNav = true}
        }
    }
}

#Preview {
    LoginView()
}
