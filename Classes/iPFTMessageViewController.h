//
//  iPFTMessageViewController.h
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 25.05.15.
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

#import "iPFTBaseViewController.h"
#import "iPFTOptionsViewController.h"

/**
	Message view for general feedback messages
 */
@interface iPFTMessageViewController : iPFTBaseViewController <UITextViewDelegate>

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UITextView *textMessage; /**< Textview for the general feedback message */
@property (nonatomic, weak) IBOutlet UIView *viewContent; /**< Container view for the textview */
@property (nonatomic, weak) IBOutlet UILabel *labelMessageDesc; /**< Label for this pages description */
@property (nonatomic, weak) IBOutlet UILabel *labelPlaceholder; /**< Label for the textview placeholder that apple forgot to implement */

#pragma mark - Instance methods

/**
	Gets called when the UIKeyboardDidShowNotification has been received
	@param notification The notification object
 */
- (void) keyboardDidShow:(NSNotification *)notification;

/**
	Gets called when the UIKeyboardWillHideNotification has been received
	@param notification The notification object
 */
- (void) keyboardWillHide:(NSNotification *)notification;

/**
	Gets called when a user taps the screen to dismiss the keyboard
	@param sender The event trigger
 */
- (void) dismissKeyboard:(UITapGestureRecognizer *)sender;

#pragma mark - IBActions

@end
