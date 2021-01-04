# grab powercfg guids necessary for lid switch action
# https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-lid-switch-close-action

# capture the active scheme GUID
$activeScheme = powercfg /getactivescheme
$regEx = '(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}'
$PwrSchemeGuid = [regex]::Match($activeScheme, $regEx).Value

# Lid Close Action: 0 = do nothing, 1 = sleep
powercfg /setdcvalueindex $PwrSchemeGuid SUB_BUTTONS LIDACTION 0
powercfg /setacvalueindex $PwrSchemeGuid SUB_BUTTONS LIDACTION 0

# Turn off display after x seconds
powercfg /setdcvalueindex $PwrSchemeGuid SUB_VIDEO VIDEOIDLE 900
powercfg /setacvalueindex $PwrSchemeGuid SUB_VIDEO VIDEOIDLE 900

# Sleep after x seconds
powercfg /setdcvalueindex $PwrSchemeGuid SUB_SLEEP STANDBYIDLE 14400
powercfg /setacvalueindex $PwrSchemeGuid SUB_SLEEP STANDBYIDLE 0

# apply settings
powercfg /s $PwrSchemeGuid
