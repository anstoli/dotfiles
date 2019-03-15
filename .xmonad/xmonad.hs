import XMonad
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Spacing
import XMonad.Util.Cursor
import XMonad.Util.EZConfig -- add custom shortcuts using additionalKeys
import XMonad.Util.SpawnOnce

import qualified Data.Map as M

-- adds gaps
myLayoutHook = spacingRaw True (Border 0 2 2 2) True (Border 2 2 2 2) True $
               layoutHook def

-- xmonad opens new window in master pane by default. In my workflow I open constantly used programs first, so new windows should be added in secondary area
myManageHook = insertPosition End Newer

myStartupHook = do
  setDefaultCursor xC_left_ptr -- sets arrow as default pointer
  spawnOnce "hsetroot -solid \"#112825\"" -- sets display background to solid color
  spawnOnce "xinput set-prop 16 310 1" -- enable tap on touchpad
  spawnOnce "compton -b -c" -- lets windows to use transparency

myModMask = mod4Mask -- uses WIN key as modifier

defaults = defaultConfig {
               modMask = myModMask
             , terminal = "termite"
             , borderWidth = 2
             , focusedBorderColor = "#95d7e2"
             , normalBorderColor = "#1c3438"
             , layoutHook = myLayoutHook
             , focusFollowsMouse = False
             , manageHook = myManageHook
             , startupHook = myStartupHook
             }
             `additionalKeys`
             [ ((myModMask, xK_F1), spawn "setxkbmap -layout us")
             , ((myModMask, xK_F2), spawn "setxkbmap -layout ua")
             , ((myModMask, xK_F3), spawn "setxkbmap -layout ru")
             ]
		
main = xmonad defaults
