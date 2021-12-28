//
//  RecentChatModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 17/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - RecentChatModelElement
struct RecentChatModelElement: Codable {
    let messageThreadID, message, messageFrom, messageTo: String
    let chatMemberID, chatMemberName: String?
    let profile: String?

    enum CodingKeys: String, CodingKey {
        case messageThreadID = "message_thread_id"
        case message
        case messageFrom = "message_from"
        case messageTo = "message_to"
        case chatMemberID = "chat_member_id"
        case chatMemberName = "chat_member_name"
        case profile
    }
}

// MARK: - ReceiveChatModel

struct ReceiveChatModel: Codable {
    let messageID, messageThreadID, messageFrom, messageTo: String
    let messageText, messageTime: String
    let messageSeen: String

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case messageThreadID = "message_thread_id"
        case messageFrom = "message_from"
        case messageTo = "message_to"
        case messageText = "message_text"
        case messageTime = "message_time"
        case messageSeen = "message_seen"
    }
}

enum MessageSeen: String, Codable {
    case yes = "yes"
}
