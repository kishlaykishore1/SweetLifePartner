//
//  PicturePrivacyModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 20/02/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - PicturePrivacyModel
struct PicturePrivacyModel: Codable {
    let profilePicShow, galleryShow: String

    enum CodingKeys: String, CodingKey {
        case profilePicShow = "profile_pic_show"
        case galleryShow = "gallery_show"
    }
}

// MARK: - GetGalleryModelElement
struct GetGalleryModelElement: Codable {
    let index: Int
    let title: String
    let image: String
}

// MARK: - GetHappyStoryElement
struct GetHappyStoryElement: Codable {
    let happyStoryID, title, getHappyStoryDescription, partnerName: String?
    let postTime, approvalStatus: String?
    let img: [String]?
    let getVideo: [GetVideo]?

    enum CodingKeys: String, CodingKey {
        case happyStoryID = "happy_story_id"
        case title
        case getHappyStoryDescription = "description"
        case partnerName = "partner_name"
        case postTime = "post_time"
        case approvalStatus = "approval_status"
        case img
        case getVideo = "get_video"
    }
}

// MARK: - GetVideo
struct GetVideo: Codable {
    let storyVideoID, type, from: String?
    let videoLink: String?
    let videoCode: String?
    let videoSrc: String?
    let previewImageName, timestamp, storyVideoUploaderID, storyID: String?

    enum CodingKeys: String, CodingKey {
        case storyVideoID = "story_video_id"
        case type, from
        case videoLink = "video_link"
        case videoCode = "video_code"
        case videoSrc = "video_src"
        case previewImageName = "preview_image_name"
        case timestamp
        case storyVideoUploaderID = "story_video_uploader_id"
        case storyID = "story_id"
    }
}
