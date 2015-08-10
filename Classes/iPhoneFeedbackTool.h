//
//  iPhoneFeedbackTool.h
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 07.05.15.
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
#import "iPFTPersistence.h"
#import "iPFTGlobal.h"
#import "iPFTInfoViewController.h"
#import "iPFTMainViewController.h"
#import "iPFTNavigationController.h"

#define iPFT_VERSION @"1.0" /**< The current iPFT version */

/**
    iPhoneFeedbackTool is the feedback tools management controller. It takes care of
 
    o Loading settings
    o Initializing the information view and displaying it if needed
    o Responding to shake gesture events
    o Initializing the main view controller and displaying it if needed
 
    This class is implemented using the Singleton pattern
 */
@interface iPhoneFeedbackTool : UIViewController

#pragma mark - Properties

#pragma mark - Instance methods

/**
	Reacts on a shake gesture event and takes further actions such as loading the settings and displaying the informatino or main view controller
    @param notification The shake gesture detected NSNotifcation object
 */
- (void) shakeGestureDetected:(NSNotification *)notification;

/**
	Displays the information view controller to inform the user about the feedback tool
 */
- (void) displayInformationViewController;

/**
	Displays the main view controller to let the user enter his feedback
 */
- (void) displayMainFeedbackViewController;

#pragma mark - Singleton implementation

/**
	Singleton implementation
	@returns The current Singleton instance
 */
+ (iPhoneFeedbackTool *) sharedInstance;

@end
