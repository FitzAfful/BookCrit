//
//  UserDefaultExtensions.swift
//  RideAlong
//
//   on 13/01/2019.
//  Copyright © 2019 RideAlong. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation


extension UserDefaults {
	
	enum AuthKeys {
		
		static let accessToken = "access_token"
		static let refreshToken = "refresh_token"
		static let tokenType = "token_type"
		static let login = "login"
		static let fcmToken = "fcmToken"
		
	}
	
	
	enum UserKeys {
		
		static let id = "id"
		static let name = "name"
		static let email = "email"
		static let phone = "phone"
		static let student_id = "student_id"
		static let token = "token"
		static let uid = "uid"
		static let image_url = "image_url"
		static let username = "username"
	}
	
	enum DeviceKeys {
		
		static let user_device_id = "device_user_device_id"
		static let device_id = "device_device_id"
		static let user_id = "device_user_id"
		static let platform = "device_platform"
		static let push_registration_id = "device_push_registration_id"
		
	}
	
	
}
