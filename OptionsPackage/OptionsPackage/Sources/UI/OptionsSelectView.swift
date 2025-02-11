//
//  OptionsSelectView.swift
//  GeneralApp
//
//  Created by ChiaYu Chang on 2025/2/10.
//

import SwiftUI

/** 選項畫面 */
struct OptionsSelectView<P: OptionProtocol>: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var optionsInfos: [P] // 選項組
    @Binding var selectedOption: P? // 選擇項目
    var onSelectedActionBlock: ((_ view: Self, _ selectedOption: P?) -> Void)? = nil // 選擇事件
    
    // MARK: -
    
    var body: some View {
        
        ZStack {
            
            List(selection: .constant(selectedOption)) {
                
                // 選項組
                ForEach(optionsInfos, id: \.self) { info in
                    
                    // 已選擇
                    let isSelected = selectedOption != nil &&
                    selectedOption?.onlyIdentification ==  info.onlyIdentification
                    
                    Button(action: {
                        
                        selectedOption = info
                        
                        onSelectedActionBlock?(self, info)
                        
                        presentationMode.wrappedValue.dismiss() // 關閉頁面
                    },
                    label: {
                        
                        HStack {
                            
                            HStack {
                                
                                if isSelected {
                                    
                                    Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                }
                            }
                            .frame(width: 44)
                            
                            Text("\(info.optionTitle ?? "")")
                            .foregroundStyle(.black)
                        }
                    })
                }
            }
        }
    }
    
    // MARK: -
}

// MARK: -


// MARK: -
