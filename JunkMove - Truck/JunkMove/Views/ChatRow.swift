//
//  ChatRow.swift
//  JunkMove
//
//  Created by Supansa Ch on 3/7/21.
//

import SwiftUI
import Firebase

struct ChatRow: View {
    
    var chatData : MessageModel
    var text: String
    let locationFetcher = LocationFetcher()
    @AppStorage("current_user") var user = ""
    
    var body: some View {
            
            HStack(spacing: 15){
                
                //NameView
                if chatData.senderDisplayName != user {NickName(name: chatData.senderDisplayName)}
                if chatData.senderDisplayName == user {Spacer(minLength: 0)}
  
                VStack(alignment: chatData.senderDisplayName == user ? .trailing : .leading, spacing: 5, content: {

                    Text(text)
                        .font(.custom("Prompt-Medium", size: 14, relativeTo: .body))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("Sky"))
                        .clipShape(ChatBubbles(myMsg: chatData.senderDisplayName == user))

                    Text(chatData.timeStamp)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(chatData.senderDisplayName != user ? .leading : .trailing , 10)
             
                })
       
//                if chatData.name == user {NickName(name: chatData.name)}
                if chatData.senderDisplayName != user {Spacer(minLength: 0)}

        }.padding(.horizontal)
        .id(chatData.id)
        
        
        HStack(spacing: 15){
            
            
            
        }
    }
}

struct NickName : View {
    
    var name : String
    @AppStorage("current_user") var user = ""
    
    var body: some View {
        
        Text(String(name))
            .font(.custom("Prompt-SemiBold", size: 16, relativeTo: .body))
            .foregroundColor(Color.white)
            .frame(width: 50, height: 50)
            .background(name == user ? Color("Sky") : Color("ocean_deep"))
            .clipShape(Circle())
    }
}

