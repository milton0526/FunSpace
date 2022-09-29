//
//  ScenicSpot.swift
//  FunSpace
//
//  Created by Milton Liu on 2022/9/28.
//

import Foundation
import MapKit

struct ScenicSpot: Codable, Identifiable {
    let scenicSpotID: String
    let scenicSpotName, descriptionDetail, description: String?
    let phone, address, zipCode, travelInfo: String?
    let openTime: String?
    let picture: Picture?
    let mapURL: String?
    let position: Position?
    let websiteURL, parkingInfo: String?
    let parkingPosition: Position?
    let ticketInfo, remarks, keyword, city: String?
    let srcUpdateTime, updateTime: String?

    var id: String {
        scenicSpotID
    }

    enum CodingKeys: String, CodingKey {
        case scenicSpotID = "ScenicSpotID"
        case scenicSpotName = "ScenicSpotName"
        case descriptionDetail = "DescriptionDetail"
        case description = "Description"
        case phone = "Phone"
        case address = "Address"
        case zipCode = "ZipCode"
        case travelInfo = "TravelInfo"
        case openTime = "OpenTime"
        case picture = "Picture"
        case mapURL = "MapUrl"
        case position = "Position"
        case websiteURL = "WebsiteUrl"
        case parkingInfo = "ParkingInfo"
        case parkingPosition = "ParkingPosition"
        case ticketInfo = "TicketInfo"
        case remarks = "Remarks"
        case keyword = "Keyword"
        case city = "City"
        case srcUpdateTime = "SrcUpdateTime"
        case updateTime = "UpdateTime"
    }
}

// MARK: - Position
struct Position: Codable, Identifiable {
    let positionLon, positionLat: Double?

    var id: Double {
        positionLat! + positionLon!
    }

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: positionLat!, longitude: positionLon!)
    }

    enum CodingKeys: String, CodingKey {
        case positionLon = "PositionLon"
        case positionLat = "PositionLat"
    }
}

// MARK: - Picture
struct Picture: Codable {
    let pictureUrl1, pictureDescription1: String?
    let pictureUrl2, pictureDescription2: String?
    let pictureUrl3, pictureDescription3: String?

    enum CodingKeys: String, CodingKey {
        case pictureUrl1 = "PictureUrl1"
        case pictureDescription1 = "PictureDescription1"
        case pictureUrl2 = "PictureUrl2"
        case pictureDescription2 = "PictureDescription2"
        case pictureUrl3 = "PictureUrl3"
        case pictureDescription3 = "PictureDescription3"
    }
}

extension ScenicSpot {
    static let preview = ScenicSpot(scenicSpotID: "C1_379000000A_000001", scenicSpotName: "大稻埕碼頭_大稻埕碼頭貨櫃市集", descriptionDetail: "大稻埕原是平埔族的居住地，因萬華（艋舺）同安人發生激烈的械鬥，造成族人移至大稻埕定居，開始大稻埕淡水河旁商店和房屋的興建，淡水港開放後，大稻埕在劉銘傳的治理下成為臺北城最繁華的物資集散中心，當中以茶葉、布料為主要貿易交易，當時的延平北路及貴德街一帶便是商業活動的重心，也讓大稻埕早年的歷史多采多姿、令人回味。", description: nil, phone: "886-2-27208889", address: nil, zipCode: "103", travelInfo: nil, openTime: "平常日以團體預約包船為主，例假日行駛固定航次，請洽詢各船公司。強烈季風、漲退潮水位差影響航行及靠泊安全，當日實際航班得由現場公告或網站預告調整。", picture: Picture(pictureUrl1: "https://www.travel.taipei/image/182690", pictureDescription1: "大稻埕碼頭_大稻埕碼頭貨櫃市集",pictureUrl2: nil, pictureDescription2: nil, pictureUrl3: nil, pictureDescription3: nil), mapURL: nil, position: Position(positionLon: 121.50760650634766, positionLat: 25.056400299072266), websiteURL: nil, parkingInfo: nil, parkingPosition: nil, ticketInfo: nil, remarks: nil, keyword: nil, city: "臺北市", srcUpdateTime: "2022-09-28T01:52:05+08:00", updateTime: "2022-09-28T02:04:46+08:00")
}
