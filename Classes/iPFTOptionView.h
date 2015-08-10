//
//  iPFTOptionView.h
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 07.06.15.
//  Copyright (c) 2015 Christian Neumann, University of Siegen. All rights reserved.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

/**
	iPFTOptionViewDelegate defines the protocol for status changes after user interaction
 */
@protocol iPFTOptionViewDelegate <NSObject>

// Optional protocol methods, just in case this view is used just for status display
@optional

/**
	SwitchStatus is called, when the user taps on the button and wants to change the options status
	@param sender Reference to the calling object (instance of this class)
 */
- (void) switchStatus:(id)sender;

@end

/**
	The iPFT_Option is a view that displays a checkmark and can have two states: 

    * selected
    * deselected
 
    It is mainly used to display the current state of an option in the 
    iPFT_OptionsViewController and lets the user change it by a given key.
 */
@interface iPFTOptionView : UIView

#pragma mark - Properties

@property (nonatomic, assign) id<iPFTOptionViewDelegate> delegate; /**< iPFTOptionViewDelegate */
@property (nonatomic, strong) UIButton *buttonSwitch; /**< Switch button for the status display and user interaction */

#pragma mark - Instance methods

/**
	Adds a button to the view to let the user switch status
 */
- (void) addButtonToView;

/**
    Set the current status and display the button accordingly
	@param value YES or NO, regarding the current status
 */
- (void) setEnabled:(BOOL)value;

#pragma mark - IBActions

/**
	Switches the current status
    @param sender The event trigger
    @return IBAction
 */
- (IBAction) buttonSwitchStatusPressed:(id)sender;

@end
