//
//  iPFTOptionsViewController.h
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
#import "iPFTSubmitViewController.h"
#import "iPFTOptionView.h"
#import "iPFTLogViewController.h"

#define TAG_OPTION_NAME 101
#define TAG_OPTION_SCREENSHOT 102
#define TAG_OPTION_MESSAGE 103
#define TAG_OPTION_STACKTRACE 104

/**
	Option selection for the feedback submission process
 */
@interface iPFTOptionsViewController : iPFTBaseViewController <iPFTOptionViewDelegate>

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet iPFTOptionView *optionName; /**< Option view to show status of name submission */
@property (nonatomic, weak) IBOutlet iPFTOptionView *optionScreenshot; /**< Option view to show status of screenshot submission */
@property (nonatomic, weak) IBOutlet iPFTOptionView *optionMessage; /**< Option view to show status of message submission */
@property (nonatomic, weak) IBOutlet iPFTOptionView *optionStackTrace; /**< Option view to show status of stacktrace submission */
@property (nonatomic, weak) IBOutlet UILabel *labelOptionsDesc; /**< Label for this pages description */
@property (nonatomic, weak) IBOutlet UILabel *labelName; /**< Label for the name option title */
@property (nonatomic, weak) IBOutlet UILabel *labelNameDesc; /**< Label for the name option description */
@property (nonatomic, weak) IBOutlet UILabel *labelEmailDesc; /**< Label for the email option description */
@property (nonatomic, weak) IBOutlet UILabel *labelScreenshot; /**< Label for the screenshot option title */
@property (nonatomic, weak) IBOutlet UILabel *labelScreenshotDesc; /**< Label for the screenshot option description */
@property (nonatomic, weak) IBOutlet UILabel *labelMessage; /**< Label for the message option title */
@property (nonatomic, weak) IBOutlet UILabel *labelMessageDesc; /**< Label for the message option description */
@property (nonatomic, weak) IBOutlet UILabel *labelStacktrace; /**< Label for the stacktrace option title */
@property (nonatomic, weak) IBOutlet UILabel *labelStacktraceDesc; /**< Label for the stacktrace option description */
@property (nonatomic, weak) IBOutlet UIButton *buttonChangeName; /**< Button for changeing the senders name */
@property (nonatomic, weak) IBOutlet UIButton *buttonViewLog; /**< Button for viewing the log and stacktrace */

#pragma mark - Instance methods

#pragma mark - IBActions

/**
	Gets called when edit name button was tapped
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) buttonEditNamePressed:(id)sender;

/**
	Gets called when view log button was tapped
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) buttonViewLogPressed:(id)sender;

@end
