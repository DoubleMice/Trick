; Finds monitor handle based on MousePosition
getMonitorHandle()
{
  ; Initialize Monitor handle
  hMon := DllCall("MonitorFromPoint"
    , "int64", 0 ; point on monitor
    , "uint", 1) ; flag to return primary monitor on failure


  ; Get Physical Monitor from handle
  VarSetCapacity(Physical_Monitor, 8 + 256, 0)

  DllCall("dxva2\GetPhysicalMonitorsFromHMONITOR"
    , "int", hMon   ; monitor handle
    , "uint", 1   ; monitor array size
    , "int", &Physical_Monitor)   ; point to array with monitor

  return hPhysMon := NumGet(Physical_Monitor)
}

destroyMonitorHandle(handle)
{
  DllCall("dxva2\DestroyPhysicalMonitor", "int", handle)
}

; Used to change the monitor source
setMonitorInputSource(source)
{
  handle := getMonitorHandle()
  DllCall("dxva2\SetVCPFeature"
    , "int", handle
    , "char", 0x60 ;VCP code for Input Source Select
    , "uint", source)
  destroyMonitorHandle(handle)
}

; Gets Monitor source
getMonitorInputSource()
{
  handle := getMonitorHandle()
  DllCall("dxva2\GetVCPFeatureAndVCPFeatureReply"
    , "int", handle
    , "char", 0x60 ;VCP code for Input Source Select
    , "Ptr", 0
    , "uint*", currentValue
    , "uint*", maximumValue)
  destroyMonitorHandle(handle)
  return currentValue
}

; my config:
;; get by 'ctrl + alt + g'
;; HP_HDMI = 18
;; PC_HDMI = 17

; get input sources~
; ctrl+alt+g
^!g::
MsgBox, % getMonitorInputSource()
return

; Switching to PC_HDMI
; ctrl+alt+p
^!p::
;to PC_HDMI(r3700x desktop)
setMonitorInputSource(17)
return

; Switching to HP_HDMI
; ctrl+alt+h
^!h::
;to HP_HDMI(HP laptop)
setMonitorInputSource(18)
return