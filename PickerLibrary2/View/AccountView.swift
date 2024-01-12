//
//  AccountView.swift
//  PickerLibrary2
//
//  Created by Yunus Can on 06/01/2024.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @Environment(\.modelContext) private var context
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @AppStorage("KullaniciAdi") var kullaniciAdi: String = ""
    @State private var exit = false
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                        .padding(20)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .overlay(Circle().stroke(Color.primary,lineWidth: 10))
                        .clipShape(Circle())
                        .padding()
                    Spacer()
                    Text(kullaniciAdi)
                        .font(.title)
                        .bold()
                        .padding()
                }
                Spacer()
                Button {
                    signOut()
                } label: {
                    Text("SignOut")
                }.foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }.fullScreenCover(isPresented: $exit) {
                Login()
            }
        }
    }
    func signOut(){
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        isLoggedIn = false
        exit = true
        
    }
}
#Preview {
    AccountView()
}
