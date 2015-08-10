//
//  iPFTInfoViewController.h
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
#import "iPFTBaseViewController.h"

#define TAG_TEXTFIELD_NAME 101 /**< Tag for the name textfield */
#define TAG_TEXTFIELD_EMAIL 102 /**< Tag for the email textfield */

#define ANIMATION_DURATION 0.25 /**< Animation duration for the moving view animation */
#define ANIMATION_CURVE 7.0 /**< Animation curve for the moving view animation */
#define ANIMATED_DISTANCE -150.0 /**< Animation curve for the moving view animation */

/**
	iPFTInfoViewController displays information for the user about this feedback tool and asks for the users name and email address
 */
@interface iPFTInfoViewController : iPFTBaseViewController <UIScrollViewDelegate, UITextFieldDelegate>
    
#pragma mark - Properties

@property (nonatomic, weak) IBOutlet UIImageView *imageViewParentView; /**< UIImageView for the background image */
@property (nonatomic, strong) UIImage *imageParentView; /**< Background image */
@property (nonatomic, strong) NSMutableArray *arrayPages; /**< Array that holds all available info pages */
@property (nonatomic, weak) IBOutlet UIScrollView *scrollMain; /**< Main scrollview that holds the content */
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl; /**< Page indicator for the main scroll view */
@property (nonatomic, weak) IBOutlet UIView *viewWelcome; /**< View for the welcome page */
@property (nonatomic, weak) IBOutlet UILabel *labelWelcomeTitle; /**< Label for the title of the welcome page */
@property (nonatomic, weak) IBOutlet UILabel *labelWelcomeDescription; /**< Label for the description of the welcome page */
@property (nonatomic, weak) IBOutlet UIView *viewStartFeedback; /**< View for the final page */
@property (nonatomic, weak) IBOutlet UILabel *labelStartFeedbackTitle; /**< Label for the title of the final page */
@property (nonatomic, weak) IBOutlet UILabel *labelStartFeedbackDescription; /**< Label for the description of the final page */
@property (nonatomic, weak) IBOutlet UIButton *buttonStartFeedback; /**< Button to close the info view and to start giving feedback */
@property (nonatomic, weak) IBOutlet UIView *viewContact; /**< View for the contact page */
@property (nonatomic, weak) IBOutlet UIView *viewContactContent; /**< View for the contact page content */
@property (nonatomic, weak) IBOutlet UILabel *labelContactTitle; /**< Label for the title of the contact page */
@property (nonatomic, weak) IBOutlet UILabel *labelContactDescription; /**< Label for the description of the contact page */
@property (nonatomic, weak) IBOutlet UITextField *textContactName; /**< Textfield for the users name */
@property (nonatomic, weak) IBOutlet UITextField *textContactEmail; /**< Textfield for the users email address */

#pragma mark - Instance methods

/**
	Moves the view up or down (i.e. to keep input fields visible)
 */
- (void) moveView:(float)animatedDistance;

/**
	Resets the view frame to its default values
 */
- (void) resetView;

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
