//
//  iPFTLogViewController.h
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

#define DISPLAY_STACK 0
#define DISPLAY_LOG 1

/**
	Display the stacktrace and log during the feedback submission process
 */
@interface iPFTLogViewController : iPFTBaseViewController

#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UILabel *labelLogViewDesc; /**< Label for this pages description */
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedSelectLog; /**< Segmented control to switch between stacktrace and application log */
@property (nonatomic, weak) IBOutlet UITextView *textStacktrace; /**< Textview to hold the stacktrace */
@property (nonatomic, weak) IBOutlet UITextView *textApplicationLog; /**< Textview to hold the application log */

#pragma mark - Instance methods

/**
	Sets the view to display the according content
	@param index Unique identifier for the content. DISPLAY_STACK for stacktrace and DISPLAY_LOG for application log
 */
- (void) setDisplay:(NSUInteger)index;

#pragma mark - IBActions

/**
	Gets called when the segmented control changed its value
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) segmentedControlChanged:(id)sender;

@end
