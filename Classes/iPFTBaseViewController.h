//
//  iPFTBaseViewController.h
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

#import <UIKit/UIKit.h>
#import "iPFTSubmitData.h"

/**
	iPFTBaseViewController ist the superclass for all interface classes and defines some general methods and styles
 */
@interface iPFTBaseViewController : UIViewController

#pragma mark - Properties

@property (nonatomic, strong) iPFTSubmitData *submitData; /**< This propety contains all data for feedback submission */

#pragma mark - Instance methods

/**
	General settings for the view controller
 */
- (void) initData;

/**
	Adds a help button to the navigationbar
 */
- (void) addHelpButtonAsRightNavbarButton;

/**
	Adds a done button to the navgation bar
 */
- (void) addDoneButtonAsRightNavbarButton;

/**
	Resigns the first responder from all possible input fields
 */
- (void) resignAllResponders;

#pragma mark - IBActions

/**
	IBAction gets called when the cancel button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) cancelButtonPressed:(id)sender;

/**
	IBAction gets called when the done button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) doneButtonPressed:(id)sender;

/**
	IBAction gets called when the help button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) helpButtonPressed:(id)sender;

/**
	IBAction gets called when the next button was pressed
	@param sender The event trigger
	@returns IBAction
 */
- (IBAction) nextButtonPressed:(id)sender;

@end
