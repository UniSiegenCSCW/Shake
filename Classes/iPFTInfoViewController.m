//
//  iPFTInfoViewController.m
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

#import "iPFTInfoViewController.h"


@implementation iPFTInfoViewController


@synthesize imageViewParentView = _imageViewParentView;
@synthesize imageParentView = _imageParentView;
@synthesize arrayPages = _arrayPages;
@synthesize scrollMain = _scrollMain;
@synthesize pageControl = _pageControl;
@synthesize viewWelcome = _viewWelcome;
@synthesize labelWelcomeTitle = _labelWelcomeTitle;
@synthesize labelWelcomeDescription = _labelWelcomeDescription;
@synthesize viewStartFeedback = _viewStartFeedback;
@synthesize labelStartFeedbackTitle = _labelStartFeedbackTitle;
@synthesize labelStartFeedbackDescription = _labelStartFeedbackDescription;
@synthesize buttonStartFeedback = _buttonStartFeedback;
@synthesize viewContact = _viewContact;
@synthesize viewContactContent = _viewContactContent;
@synthesize labelContactTitle = _labelContactTitle;
@synthesize labelContactDescription = _labelContactDescription;
@synthesize textContactName = _textContactName;
@synthesize textContactEmail = _textContactEmail;


#pragma mark - Instance methods


- (void) initData {
    
    [super initData];
    
    // Set backgorund image
    _imageViewParentView.image = _imageParentView;
    
    // Disable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:YES];
    
    // The info view controller has been shown at least once and doesn´t have to be shown again
    [iPFTPersistence setInfoHasBeenShown];
    
    // Listen for UIKeyboard notifications to react on keyboard visibility status
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Add tap gesture recognizer to help the user to dismiss the keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
    // Collect the pages to display
    _arrayPages = [[NSMutableArray alloc] init];
    [_arrayPages addObject:_viewWelcome];
    [_arrayPages addObject:_viewContact];
    [_arrayPages addObject:_viewStartFeedback];
    
    // Get the applications main window and sizes
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    float width = window.frame.size.width;
    float height = window.frame.size.height;
    
    // Number of pages to display
    int pages = (int)[_arrayPages count];
    _pageControl.numberOfPages = [_arrayPages count];
    _pageControl.currentPage = 0;
    
    // Fix scrollviews content size to match the number of pages
    _scrollMain.contentSize = CGSizeMake(width * pages, height);
    
    // Put the pages into right position and add them to the main scroll view
    for ( int index = 0; index < pages; index++ ) {
        
        UIView *view = (UIView *)[_arrayPages objectAtIndex:index];
        view.frame = CGRectMake(index * width, 0, width, height);
        [_scrollMain addSubview:view];
    }
    
    // Fill labels and textfields with localized data
    _labelWelcomeTitle.text             = iPFTLocalizedString(@"iPFT_WELCOME_TITLE");
    _labelWelcomeDescription.text       = iPFTLocalizedString(@"iPFT_WELCOME_DESC");
    [_labelWelcomeDescription sizeToFit];
    _labelContactTitle.text             = iPFTLocalizedString(@"iPFT_CONTACT_TITLE");
    _labelContactDescription.text       = iPFTLocalizedString(@"iPFT_CONTACT_DESC");
    [_labelContactDescription sizeToFit];
    _textContactName.placeholder        = iPFTLocalizedString(@"iPFT_CONTACT_ENTER_NAME");
    _textContactEmail.placeholder       = iPFTLocalizedString(@"iPFT_CONTACT_ENTER_EMAIL");
    _labelStartFeedbackTitle.text       = iPFTLocalizedString(@"iPFT_START_TITLE");
    _labelStartFeedbackDescription.text = iPFTLocalizedString(@"iPFT_START_DESC");
    [_labelStartFeedbackDescription sizeToFit];
    
    // Customize done button
    [_buttonStartFeedback setTitle:iPFTLocalizedString(@"iPFT_START_BUTTON") forState:UIControlStateNormal];
    _buttonStartFeedback.clipsToBounds = YES;
    
    // Set predefined values
    _textContactName.text = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SENDER_NAME];
    _textContactEmail.text = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SENDER_EMAIL];
}


- (void) resignAllResponders {
    
    // Resign first responder on active textfield
    [_textContactName resignFirstResponder];
    [_textContactEmail resignFirstResponder];
}


- (void) moveView:(float)animatedDistance {
    
    // Move view up or down
    CGRect viewFrame = self.viewContactContent.frame;
    viewFrame.origin.y += animatedDistance;
    
    // Animate movement
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:ANIMATION_CURVE];
    [_viewContactContent setFrame:viewFrame];
    [UIView commitAnimations];
}


- (void) resetView {
    
    // Retrieve the content views frame and proceed if it´s not its default position
    CGRect viewFrame = self.viewContactContent.frame;
    if ( viewFrame.origin.y != 0 ) {
        
        // Reset view to its default position
        viewFrame.origin.y = 0;
        
        // Animate movement
        [UIView beginAnimations:@"ResetView" context:nil];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [UIView setAnimationCurve:ANIMATION_CURVE];
        [_viewContactContent setFrame:viewFrame];
        [UIView commitAnimations];
    }
}


- (void) keyboardDidShow:(NSNotification *)notification {
    
    // Retrieve keyboard size
    CGRect keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Retrieve the content views size and shorten it by the height of the keyboard
    CGRect frame = _viewContactContent.frame;
    frame.size.height -= keyboard.size.height;
    
    // If the bottom textfield is not in the visible part of the view, then fix the content views position
    if (!CGRectContainsPoint(frame, _textContactEmail.frame.origin)) {
        
        [self moveView:ANIMATED_DISTANCE];
    }
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    // Resetting the views position when the keyboard is about to get dismissed
    [self resetView];
}


- (void) dismissKeyboard:(UITapGestureRecognizer *)sender {
    
    // Resign first responder
    [self resignAllResponders];
}


#pragma mark - UIScrollView delegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    
    // Get the applications main window and sizes
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    float width = window.frame.size.width;
    
    // Calculate the current page and update the UIPAgeControl
    uint page = sender.contentOffset.x / width;
    [_pageControl setCurrentPage:page];
}


#pragma mark - UITextView delegate


- (void) textFieldDidEndEditing:(UITextField *)textField {

    // Save entered values
    switch ( textField.tag ) {
            
        case TAG_TEXTFIELD_NAME:
            
            // Write new name to user defaults
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:KEY_SENDER_NAME];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
            
        case TAG_TEXTFIELD_EMAIL:
            
            // Write new email to user defaults
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:KEY_SENDER_EMAIL];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
            
        default:
            break;
    }
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    switch ( textField.tag ) {
            
        case TAG_TEXTFIELD_NAME:
            // Select the next textfield
            [_textContactEmail becomeFirstResponder];
            break;
            
        case TAG_TEXTFIELD_EMAIL:
            // Resign all responders
            [self resignAllResponders];
            break;
            
        default:
            break;
    }
    
    return YES;
}


#pragma mark - Memory management


- (void) dealloc {
    
    // Unsubscribe from NSNotification messages
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - IBActions


- (IBAction) doneButtonPressed:(id)sender {
    
    // Close the info view
    [self dismissViewControllerAnimated:YES completion:^{
        
        // Enable processing of further shake gestures
        [iPFTPersistence setBlockShakeGesture:NO];
        
        // Post a displayMainFeedbackViewController to show the main feedback tool controller
        [[NSNotificationCenter defaultCenter] postNotificationName:@"displayMainFeedbackViewController" object:self];
    }];
}


@end
