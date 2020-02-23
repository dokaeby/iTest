//
//  ContentsModel.swift
//  IdusTest
//
//  Created by 양성훈 on 2020/02/19.
//  Copyright © 2020 양성훈. All rights reserved.
//

import Foundation

struct ContentsModel: Decodable {
    var resultCount: Int
    var results: [iTunesSearchResult]
    
    enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
    
    init() {
        resultCount = 0
        results = []
    }
}

public struct iTunesSearchResult: Decodable {
    var appletvScreenshotUrls: [String?]
    var screenshotUrls: [String?]
    var ipadScreenshotUrls: [String?]
    var artworkUrl512:String?
    var isGameCenterEnabled:Bool
    var artistViewUrl:String?
    var artworkUrl60:String?
    var artworkUrl100:String?
    var supportedDevices:[String]
    var advisories:[String?]
    var kind:String?
    var features:[String]
    var languageCodesISO2A:[String]
    var fileSizeBytes:String?
    var sellerUrl:String?
    var averageUserRatingForCurrentVersion:Float
    var userRatingCountForCurrentVersion:Int
    var trackContentRating:String?
    var trackCensoredName:String?
    var trackViewUrl:String?
    var contentAdvisoryRating:String?
    var trackId:Int
    var trackName:String?
    var releaseDate:String?
    var currentVersionReleaseDate:String?
    var releaseNotes:String?
    var isVppDeviceBasedLicensingEnabled:Bool
    var primaryGenreName:String?
    var genreIds:[String?]
    var sellerName:String?
    var formattedPrice:String?
    var minimumOsVersion:String?
    var currency:String?
    var version:String?
    var wrapperType:String?
    var artistId:Int
    var artistName:String?
    var genres:[String?]
    var price:Float
    var description:String?
    var bundleId:String?
    var averageUserRating:Float
    var userRatingCount:Int?
    
    enum CodingKeys: String, CodingKey {
        case appletvScreenshotUrls, screenshotUrls, ipadScreenshotUrls,artworkUrl512, isGameCenterEnabled, artistViewUrl,
        artworkUrl60, artworkUrl100, supportedDevices, advisories, kind, features, languageCodesISO2A, fileSizeBytes,
        sellerUrl, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, trackContentRating,
        trackCensoredName, trackViewUrl, contentAdvisoryRating, trackId, trackName, releaseDate,
        currentVersionReleaseDate, releaseNotes, isVppDeviceBasedLicensingEnabled, primaryGenreName,
        genreIds, sellerName, formattedPrice, minimumOsVersion, currency, version, wrapperType, artistId,
        artistName, genres, price, description, bundleId, averageUserRating, userRatingCount
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.appletvScreenshotUrls = try container.decodeIfPresent([String].self, forKey: .appletvScreenshotUrls) ?? []
        self.screenshotUrls = try container.decodeIfPresent([String].self, forKey: .screenshotUrls) ?? []
        self.ipadScreenshotUrls = try container.decodeIfPresent([String].self, forKey: .ipadScreenshotUrls) ?? []
        self.artworkUrl512 = try container.decodeIfPresent(String.self, forKey: .artworkUrl512)
        self.isGameCenterEnabled = try container.decodeIfPresent(Bool.self, forKey: .isGameCenterEnabled) ?? false
        self.artistViewUrl = try container.decodeIfPresent(String.self, forKey: .artistViewUrl)
        self.artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        self.supportedDevices = try container.decodeIfPresent([String].self, forKey: .supportedDevices) ?? []
        self.advisories = try container.decodeIfPresent([String].self, forKey: .advisories) ?? []
        self.kind = try container.decodeIfPresent(String.self, forKey: .kind)
        self.features = try container.decodeIfPresent([String].self , forKey: .features) ?? []
        self.languageCodesISO2A = try container.decodeIfPresent([String].self, forKey: .languageCodesISO2A) ?? []
        self.fileSizeBytes = try container.decodeIfPresent(String.self, forKey: .fileSizeBytes)
        self.sellerUrl = try container.decodeIfPresent(String.self, forKey: .sellerUrl)
        self.averageUserRatingForCurrentVersion = try container.decodeIfPresent(Float.self, forKey: .averageUserRatingForCurrentVersion) ?? 0.0
        self.userRatingCountForCurrentVersion = try container.decodeIfPresent(Int.self, forKey: .userRatingCountForCurrentVersion) ?? 0
        self.trackContentRating = try container.decodeIfPresent(String.self, forKey: .trackContentRating)
        self.trackCensoredName = try container.decodeIfPresent(String.self, forKey: .trackCensoredName)
        self.trackViewUrl = try container.decodeIfPresent(String.self, forKey: .trackViewUrl)
        self.contentAdvisoryRating = try container.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        self.trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.currentVersionReleaseDate = try container.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate)
        self.releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes)
        self.isVppDeviceBasedLicensingEnabled = try container.decodeIfPresent(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled) ?? false
        self.primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)
        self.genreIds = try container.decodeIfPresent([String].self, forKey: .genreIds) ?? []
        self.sellerName = try container.decodeIfPresent(String.self, forKey: .sellerName)
        self.formattedPrice = try container.decodeIfPresent(String.self, forKey: .formattedPrice)
        self.minimumOsVersion = try container.decodeIfPresent(String.self, forKey: .minimumOsVersion)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
        self.version = try container.decodeIfPresent(String.self, forKey: .version)
        self.wrapperType = try container.decodeIfPresent(String.self, forKey: .wrapperType)
        self.artistId = try container.decodeIfPresent(Int.self, forKey: .artistId) ?? 0
        self.artistName = try container.decodeIfPresent(String.self, forKey: .sellerUrl)
        self.genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        self.price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0.0
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.bundleId = try container.decodeIfPresent(String.self, forKey: .bundleId)
        self.averageUserRating = try container.decodeIfPresent(Float.self, forKey: .averageUserRating) ?? 0.0
        self.userRatingCount = try container.decodeIfPresent(Int.self, forKey: .userRatingCount)
        
    }
    
}

