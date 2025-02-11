//
//  OptionProtocol.swift
//  
//
//  Created by ChiaYu Chang on 2024/5/9.
//

import Foundation

/** 選項實作介面 */
protocol OptionProtocol: Hashable, Equatable {
    
    var onlyIdentification: String { get } // 唯一識別
    var optionTitle: String? { get } // 顯示名稱
}

// MARK: -

extension Array where Element: OptionProtocol {
    
    func getInfo(onlyIdentification: String?) -> Element? {
        
        if let onlyIdentification = onlyIdentification {
            
            let firstInfo = first { $0.onlyIdentification == onlyIdentification }
            
            return firstInfo
        }
        
        return nil
    }
}

// MARK: - Hashable

extension OptionProtocol {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        lhs.onlyIdentification == rhs.onlyIdentification
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(onlyIdentification)
    }
}

// MARK: -
