//
//  OptionsPickerView.swift
//  GeneralApp
//
//  Created by ChiaYu Chang on 2025/2/11.
//

import SwiftUI

/** 選項 Picker 樣式 */
enum OptionsViewPickerStyle {
    
    case menu
    case picker // inline
    case segmented
}

/** 選項 Picker */
struct OptionsPickerView<P: OptionProtocol>: View {
    
    // MARK: -
    
    var style: OptionsViewPickerStyle // 選單樣式
    var title: String // 選項標題
    
    @Binding var optionsInfos: [P] // 選項組
    @Binding var selectedOption: P? // 選擇項目
    
    init(style: OptionsViewPickerStyle = .menu,
         title: String = "",
         optionsInfos: Binding<[P]>,
         selectedOption: Binding<P?>,
         onSelectedActionBlock: ((_ view: Self, _ selectedOption: P?) -> Void)? = nil) {
        
        self.style = style
        self.title = title
        
        _optionsInfos = optionsInfos
        _selectedOption = selectedOption
        
        self.onSelectedActionBlock = onSelectedActionBlock
        
        // 設定預設選項參數
        let selectedId: String = selectedOption.wrappedValue?.onlyIdentification ?? ""
        
        let selectedOnlyIdentification = selectedId.isEmpty ? nilMark : selectedId
        
        self.selectedOnlyIdentification = selectedOnlyIdentification // 更新選擇識別 for ID
    }
    
    @State private var selectedOnlyIdentification: String // 選擇ID
    
    // MARK: -
    
    var onSelectedActionBlock: ((_ view: Self, _ selectedOption: P?) -> Void)? = nil // 選擇事件
    
    // MARK: -
    
    private let allowNil: Bool = true // 允許 nil 值
    private let nilTitle: String = "" // nil 標題
    private let nilMark: String = "<nil>" // nil 標記
    
    // MARK: -
    
    var body: some View {
        
        ZStack {
            
            // 預設呈現樣式
            Picker(title, selection: $selectedOnlyIdentification) {
                
                // 允許 nil 值
                if allowNil {
                    
                    Text(nilTitle).tag(nilMark) // Nil 選項
                }
                
                // ＊＊＊錯誤選項防呆，避免產生對應錯誤（在異動 optionsInfos 時，需重新設定 selectedOption，避免產生對應錯誤）
                if selectedOnlyIdentification != nilMark {
                    
                    let selectIndex = optionsInfos.firstIndex {
                        $0.onlyIdentification == selectedOnlyIdentification
                    }
                    
                    if selectIndex == nil {
                        
                        // 錯誤選項
                        Text("not selected option").tag(selectedOnlyIdentification)
                    }
                }
                
                // 選項組
                ForEach(optionsInfos, id: \.onlyIdentification) { info in
                    
                    Text("\(info.optionTitle ?? "")")
                }
            }
            // 設定樣式
            .modifier(OptionsPickerView.StyleModifier(style: style))
            // 選擇資料改變（私有）
            .onChange(of: selectedOnlyIdentification) { value in
                
                let selectedOption = optionsInfos.getInfo(onlyIdentification: value)
                
                // 過濾重複觸發（包含 外部操作 設定對應 onlyIdentification）
                if self.selectedOption?.onlyIdentification != selectedOption?.onlyIdentification {
                    
                    self.selectedOption = selectedOption
                    
                    onSelectedActionBlock?(self, selectedOption)
                }
            }
            // 選擇資料改變（外部操作 For OptionInfo）
            .onChange(of: selectedOption) { value in
                
                settingByOption(selectedOption: value)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: -
}

// MARK:-

private extension OptionsPickerView {
    
    /** setting option for selectedOnlyIdentification */
    func settingByOption(selectedOption: P?) {
        
        let selectedId: String = selectedOption?.onlyIdentification ?? ""
        
        let selectedOnlyIdentification = selectedId.isEmpty ? nilMark : selectedId
        
        if selectedOnlyIdentification != self.selectedOnlyIdentification {
            
            self.selectedOnlyIdentification = selectedOnlyIdentification // 更新選擇識別 for ID
        }
    }
}

// MARK:-

private extension OptionsPickerView {
    
    /** Picker Style View Modifier */
    struct StyleModifier: ViewModifier {
        
        let style: OptionsViewPickerStyle
        
        func body(content: Content) -> some View {
            
            switch style {
            
                case .menu:
                
                    content
                    .pickerStyle(.menu)
                
                case .picker:
                
                    content
                    .pickerStyle(.inline)
                
                case .segmented:
                
                    content
                    .pickerStyle(.segmented)
            }
        }
    }
}

// MARK:-
