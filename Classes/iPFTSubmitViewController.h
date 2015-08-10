//
//  iPFTSubmitViewController.h
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
#import "iPFTGlobal.h"
#import "iPFTModuleNativeMail.h"
#import "iPFTModuleRedmineTicket.h"

/**
	Feedback submission view for sending feedback and obtaining a status
 */
@interface iPFTSubmitViewController : iPFTBaseViewController <iPFTModuleDelegate>

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UILabel *labelSubmitTitle; /**< Label for this views title */
@property (nonatomic, weak) IBOutlet UILabel *labelSubmitDesc; /**< Label for this views decription */
@property (nonatomic, weak) IBOutlet UIView *viewActivityIndicator; /**< Activity indicator for the feedback sending process */

#pragma mark - Instance methods

#pragma mark - IBActions

/**
	IBAction gets called when the send button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) sendButtonPressed:(id)sender;

@end
