//
//  iPFTMessageViewController.m
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

#import "iPFTMessageViewController.h"


@implementation iPFTMessageViewController


@synthesize textMessage = _textMessage;
@synthesize viewContent = _viewContent;
@synthesize labelMessageDesc = _labelMessageDesc;
@synthesize labelPlaceholder = _labelPlaceholder;


#pragma mark - Instance methods


- (void) initData {

    [super initData];
    
    // Set this views title
    self.title = iPFTLocalizedString(@"iPFT_TITLE_MESSAGE");
    
    // Set this views description
    _labelMessageDesc.text = iPFTLocalizedString(@"iPFT_MESSAGE_DESC");
    CGRect originalFrame = _labelMessageDesc.frame;
    [_labelMessageDesc sizeToFit];
    CGRect newFrame = _labelMessageDesc.frame;
    _labelMessageDesc.frame = CGRectMake(originalFrame.origin.x, newFrame.origin.y, originalFrame.size.width, newFrame.size.height);
    
    // Set default message
    _textMessage.text = self.submitData.message;
    
    // Set the placeholder
    _labelPlaceholder.text = iPFTLocalizedString(@"iPFT_MESSAGE_PLACEHOLDER");
    [_labelPlaceholder sizeToFit];
    if ( _textMessage.text == nil || [_textMessage.text isEqualToString:@""] ) {
        
        _labelPlaceholder.hidden = NO;
    }
    else {
        
        _labelPlaceholder.hidden = YES;
    }
    
    // Add a help button to the navigationbar
    [self addHelpButtonAsRightNavbarButton];
    
    // Add BarButtonItems to the toolbar
    UIBarButtonItem *buttonCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelButtonPressed:)];
    
    UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    fixSpace.width = 10.0;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    UIBarButtonItem *buttonNext = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_NEXT")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:fixSpace, buttonCancel, flexSpace, buttonNext, fixSpace, nil];
    
    [self setToolbarItems:arrayItems];
    
    // Listen for UIKeyboard notifications to react on keyboard visibility status
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // Add tap gesture recognizer to help the user to dismiss the keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
}


- (void) resignAllResponders {
    
    // Resign textviews first responder
    [_textMessage resignFirstResponder];
}


- (void) keyboardDidShow:(NSNotification *)notification {
    
    // Retrieve keyboard size
    CGRect keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Retrieve the textviews size and shorten it by the height of the keyboard
    CGRect frame = _viewContent.frame;
    frame.size.height -= ( keyboard.size.height - self.navigationController.toolbar.frame.size.height );
    
    // Animate the resizing of the textview
    [UIView beginAnimations:@"resize textview for keyboard" context:nil];
    [_viewContent setFrame:frame];
    [UIView commitAnimations];
    
    [self addDoneButtonAsRightNavbarButton];
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    // Retrieve keyboard size
    CGRect keyboard = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Retrieve the textviews size and expand it by the height of the keyboard
    CGRect frame = _viewContent.frame;
    frame.size.height += ( keyboard.size.height - self.navigationController.toolbar.frame.size.height );
    
    // Animate the resizing of the textview
    [UIView beginAnimations:@"resize textview for keyboard" context:nil];
    [_viewContent setFrame:frame];
    [UIView commitAnimations];
    
    // Remove the done button and add the help button to the navigation bar
    [self addHelpButtonAsRightNavbarButton];
}


- (void) dismissKeyboard:(UITapGestureRecognizer *)sender {
    
    // Resign first responder
    [_textMessage resignFirstResponder];
}


#pragma mark - UITextView delegate


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    // Hide placeholder while editing
    _labelPlaceholder.hidden = YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    // Save message
    self.submitData.message = textView.text;
    
    // Display placeholder if needed
    if ( [textView.text isEqualToString:@""] ) {
        
        _labelPlaceholder.hidden = NO;
    }
}


#pragma mark - Memory management


- (void) dealloc {
    
    // Unsubscribe from NSNotification messages
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - IBActions


- (IBAction) nextButtonPressed:(id)sender {

    // Initialize options view and push it
    iPFTOptionsViewController *viewOptions = [[iPFTOptionsViewController alloc] initWithNibName:@"iPFTOptionsViewController" bundle:nil];
    viewOptions.submitData = self.submitData;
    [self.navigationController pushViewController:viewOptions animated:YES];
}


- (IBAction) cancelButtonPressed:(id)sender {
 
    // Enable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:NO];
    
    // Call super class method
    [super cancelButtonPressed:sender];
}


@end
