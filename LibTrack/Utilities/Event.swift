//
//  Event.swift
//  Freshpay
//
//   on 04/11/2017.
//  Copyright © 2017 Freshbakery. All rights reserved.
//

import Foundation

class Event: NSObject {
	var status: String;
	var message: String
	var id: Int
	
	init(status_: String, message_: String, id_:Int) {
		self.status = status_
		self.message = message_
		self.id = id_
	}
}
