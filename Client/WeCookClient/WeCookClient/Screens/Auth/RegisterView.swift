//
//  RegisterView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel = AuthViewModel.shared
    @ObservedObject var appViewModel = AppViewModel.shared

    var body: some View {
        NavigationStack{
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
                    TextField("First Name",text: $viewModel.user.fName)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.vertical,5)
                    TextField("Last Name",text: $viewModel.user.lName)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.vertical,5)
                    TextField("Email",text: $viewModel.user.email)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.vertical,5)
                    SecureField("Password",text: $viewModel.user.password)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    Button{
                        Task {
                            await viewModel.saveUser()
                            if viewModel.registerSuccess { appViewModel.selectedView = .login }
                        }
                    } label: {
                        Text("Sign Up")
                            .frame(width:100,height:30)
                            .background(.white)
                    }.clipShape(.capsule)
                    Text("Already have an account?")
                        .foregroundStyle(.blue)
                        .onTapGesture{appViewModel.selectedView = .login}
                    Spacer()
                }
                .padding(.vertical,150)
                .padding(.horizontal, 50)
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Register")
            .toolbar(.hidden)
            .alert(item: $viewModel.alertItem) {alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
        }
        .onAppear{appViewModel.hideNav = true}
    }
}

#Preview {
    RegisterView()
}
