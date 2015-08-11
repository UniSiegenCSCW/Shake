# Shake 1.0

This project is a drop-in library that supports developers to gather productive feedback from their app users (i.e. beta testers).

## Description

When an app user shakes the device, a screenshot of the current view is taken and the user can annotate it or add a general message as a feedback and send it to the developers.

## Installation

1. Download the project
1. Unzip it
1. Drag & drop the content of the "classes" folder to your project

The project is already setup tp send a mail to the developers using the native apple mail app.
Enter the name of the development team and the email address in 
  
	iPFTModuleNativeMail.plist

If you dont have ARC enabled, you will need to set a -fobjc-arc compiler flag on the .m source files. 

## Redmine Integration

This tool can be used with Redmine and feedback messages go directly into your issue tracker.
If you want to use the tool with Redmine, you need to change the active module in 

	iPFTConfig.h

Then enter your data in

	iPFTModuleRedmineTicket.plist

Currently, only one module can be used at a time.  

## Usage

Tell your users to shake their devices :)

## Future Directions

1. Provide CocoaPods podspec installation
1. Support Github 
1. Support GitLab 
1. API for custom use
1. Save feedback for later use (support offline feedback)

## License

	The MIT License (MIT)
	
	Copyright (c) 2015 Christian Neumann, University of Siegen
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

## Credits

#### Copyright

	Copyright (c) 2015 Christian Neumann, University of Siegen. All rights reserved.

#### Project Management

	Julian Dax, University of Siegen

#### Developer

	Christian Neumann, University of Siegen

#### Used Pictures

The artwork for this project is based on the following resources

1. iPFT_Shake.png

        https://www.iconfinder.com/icons/476326/call_handheld_iphone_mobile_phone_smartphone_telepho$
        License: Free for commercial use

        https://www.iconfinder.com/icons/50785/arrow_right_icon#size=64
        License: Creative Commons (Attribution-Share Alike 3.0 Unported)

2. iPFT_Contact.png

        https://www.iconfinder.com/icons/211731/contact_outline_icon#size=128
        License: MIT

3. iPFT_StartFeedback.png

        https://www.iconfinder.com/icons/322295/accepted_agree_communication_creative_facebook_favor$
        License: Creative Commons (Attribution 2.5 Generic)

4. iPFT_Option.png

	https://www.iconfinder.com/icons/326563/box_check_icon#size=128
	License: Free for commercial use

5. iPFT_Sending.png

	https://www.iconfinder.com/icons/186386/paper_plane_plane_send_icon#size=128
	License: Free for commercial use

6. iPFT_TouchEvent.png

	https://www.iconfinder.com/icons/310114/apps_calling_fingers_games_mobile_mobile_phone_phone_screen_touch_touching_touchscreen_icon#size=128
	License: Free for commercial use 

7. iPFT_Brush.png

	https://www.iconfinder.com/icons/284087/edit_editor_pen_pencil_write_icon#size=128
	License: Free for commercial use

8. iPFT_Success.png

	https://www.iconfinder.com/icons/186405/available_checkmark_done_icon#size=256
	License: Free for commercial use

9. iPFT_Failed.png

	https://www.iconfinder.com/icons/186389/delete_remove_icon#size=128
	License: Free for commercial use

