//
//  ContentView.swift
//  OptionsPackage
//
//  Created by ChiaYu Chang on 2025/2/11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path: NavigationPath = .init()
    
    @State private var mainInfos: [OptionInfo] = [
        .init(identification: "1", name: "選項 1", subs: [
            .init(identification: "1_1", name: "子選項 1_1")
        ]),
        .init(identification: "2", name: "選項 2", subs: [
            .init(identification: "2_1", name: "子選項 2_1")
        ]),
        .init(identification: "3", name: "選項 3", subs: [
            .init(identification: "3_1", name: "子選項 3_1")
        ])
    ] // 主選項
    
    @State private var subInfos: [OptionInfo] = [] // 子選項
    
    @State private var selectedMainOption: OptionInfo? // 已選擇（主）
    @State private var selectedSubOption: OptionInfo? // 已選擇（子）
    
    @State private var isMainSelectAction: Bool = false // 選擇頁面（主）
    @State private var isSubSelectAction: Bool = false // 選擇頁面（子）
    
    // MARK: -
    
    /** 設定主選項 */
    private func setting(selectedMainOption selectedOption: OptionInfo?) {
        
        selectedSubOption = nil // 清除子項目選擇
        subInfos = selectedOption?.subs ?? []
    }
    
    // MARK: -
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            ZStack {
                
                VStack(spacing: 16) {
                    
                    // MARK: - Picker
                    
                    HStack {
                        
                        let pickerStyle: OptionsViewPickerStyle = .picker
                        
                        /** 選項選擇元件（左） */
                        OptionsPickerView(
                            style: pickerStyle,
                            optionsInfos: $mainInfos,
                            selectedOption: $selectedMainOption,
                            onSelectedActionBlock: { view, selectedOption in
                                
                                // Main Infos Selected Action
                                setting(selectedMainOption: selectedOption) // 設定主選項
                            })
                        
                        /** 選項選擇元件（右） */
                        OptionsPickerView(
                            style: pickerStyle,
                            optionsInfos: $subInfos,
                            selectedOption: $selectedSubOption,
                            onSelectedActionBlock: { view, selectedOption in
                                
                                // Sub Infos Selected Action
                            })
                    }
                    
                    // MARK: - Menu
                    
                    HStack {
                        
                        let pickerStyle: OptionsViewPickerStyle = .menu
                        
                        /** 選項選擇元件（左） */
                        OptionsPickerView(
                            style: pickerStyle,
                            optionsInfos: $mainInfos,
                            selectedOption: $selectedMainOption,
                            onSelectedActionBlock: { view, selectedOption in
                                
                                // Main Infos Selected Action
                                setting(selectedMainOption: selectedOption) // 設定主選項
                            })
                        
                        /** 選項選擇元件（右） */
                        OptionsPickerView(
                            style: pickerStyle,
                            optionsInfos: $subInfos,
                            selectedOption: $selectedSubOption,
                            onSelectedActionBlock: { view, selectedOption in
                                
                                // Sub Infos Selected Action
                            })
                    }
                    
                    // MARK: -
                    
                    HStack {
                        
                        /** 自定義按鈕與選擇畫面（左） */
                        Button(action: {
                            
                            isMainSelectAction = true
                        },
                               label: {
                            
                            Text(selectedMainOption?.optionTitle ?? "未選擇")
                                .frame(maxWidth: .infinity)
                        })
                        
                        /** 自定義按鈕與選擇畫面（右） */
                        Button(action: {
                            
                            isSubSelectAction = true
                        },
                               label: {
                            
                            Text(selectedSubOption?.optionTitle ?? "未選擇")
                                .frame(maxWidth: .infinity)
                        })
                    }
                    
                    HStack {
                        
                        /** 新增選項（左） */
                        Button(action: {
                            
                            let optionsInfo: OptionInfo
                            
                            let identification = "\(mainInfos.count + 1)"
                            
                            optionsInfo = .init(identification: identification, name: "選項 \(identification)")
                            
                            mainInfos.append(optionsInfo)
                        },
                               label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                Text("新增主選項")
                            }
                            .frame(maxWidth: .infinity)
                        })
                        
                        /** 新增選項（右） */
                        Button(action: {
                            
                            if let mainOption = selectedMainOption {
                                
                                var subInfos = mainOption.subs ?? []
                                
                                let subInfo: OptionInfo
                                
                                let identification = "\(mainOption.onlyIdentification)_\(subInfos.count + 1)"
                                
                                subInfo = .init(identification: identification, name: "子選項 \(identification)")
                                
                                subInfos.append(subInfo)
                                
                                mainOption.subs = subInfos
                                
                                self.subInfos = subInfos // 更新子選項
                            }
                        },
                               label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                Text("新增子選項")
                            }
                            .frame(maxWidth: .infinity)
                        })
                    }
                    
                    // MARK: -
                    
                    HStack {
                        
                        /** 強制選擇按鈕（左） */
                        Button(action: {
                            
                            let selectInfo = mainInfos.last
                            
                            selectedMainOption = selectInfo
                            subInfos = selectInfo?.subs ?? []
                            selectedSubOption = subInfos.last
                        },
                               label: {
                            
                            Text("選擇最後項目")
                                .frame(maxWidth: .infinity)
                        })
                    }
                    
                    // MARK: -
                }
            }
            // 選擇頁面（主選項）
            .navigationDestination(isPresented: $isMainSelectAction,
                                   destination: {
                
                OptionsSelectView(
                    optionsInfos: $mainInfos,
                    selectedOption: $selectedMainOption, onSelectedActionBlock: { view, selectedOption in
                        
                        // Main Infos Selected Action
                        setting(selectedMainOption: selectedOption) // 設定主選項
                    })
            })
            // 選擇頁面（子選項）
            .navigationDestination(isPresented: $isSubSelectAction,
                                   destination: {
                
                OptionsSelectView(
                    optionsInfos: $subInfos,
                    selectedOption: $selectedSubOption, onSelectedActionBlock: { view, selectedOption in
                        
                        // Sub Infos Selected Action
                    })
            })
        }
    }
}

#Preview {
    ContentView()
}
