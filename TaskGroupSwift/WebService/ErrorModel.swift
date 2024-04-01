//
//  ErrorModel.swift
//  TaskGroupSwift
//
//  Created by Ayush Gupta on 01/04/24.
//

import Foundation

enum ErrorType: LocalizedError, Equatable {
    case invalidResponse
    case responseParsingError
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response."
        case .responseParsingError:
            return "Error while Parsing Json data."
        case .invalidURL:
            return "Request URL is invalid or empty."
        }
    }
}
