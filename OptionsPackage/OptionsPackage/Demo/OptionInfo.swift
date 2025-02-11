//
//  OptionInfo.swift
//  
//
//  Created by ChiaYu Chang on 2024/5/10.
//

import Foundation

/** 選項資訊 */
class OptionInfo {
    
    var identification: String? // ID 識別
    var name: String? // 選項名稱
    var subs: [OptionInfo]? // 子選項
}

// MARK: - 初始化擴展

extension OptionInfo {
    
    convenience init(identification: String?, name: String?, subs: [OptionInfo]? = nil) {
        
        self.init()
        
        self.identification = identification
        self.name = name
        self.subs = subs
    }
}

// MARK: - OptionProtocol

extension OptionInfo: OptionProtocol {
    
    var onlyIdentification: String { return identification ?? "" } // 唯一識別
    
    var optionTitle: String? { return name ?? "" } // 顯示名稱
}

// MARK: -
