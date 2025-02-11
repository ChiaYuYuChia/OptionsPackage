# OptionsPackage

Swift Options Operate View

OptionInfo Implementation OptionProtocol Protocol

Picker View Operate
            
    OptionsPickerView(style: , optionsInfos: , selectedOption: , onSelectedActionBlock: )
    
        style is PickerStyle
        optionsInfos is Binding<[OptionProtocol]>
        selectedOption is Binding<OptionProtocol?>
        onSelectedActionBlock is selected call action
            
Open A New Page

    OptionsSelectView(optionsInfos: , selectedOption: $selectedMainOption, onSelectedActionBlock: )
    
        optionsInfos is Binding<[OptionProtocol]>
        selectedOption is Binding<OptionProtocol?>
        onSelectedActionBlock is selected call action
