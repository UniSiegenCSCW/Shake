//
//  iPFTSubmitViewController.m
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

#import "iPFTSubmitViewController.h"


@implementation iPFTSubmitViewController


@synthesize labelSubmitTitle = _labelSubmitTitle;
@synthesize labelSubmitDesc = _labelSubmitDesc;
@synthesize viewActivityIndicator = _viewActivityIndicator;


#pragma mark - Instance methods


- (void) initData {

    [super initData];
    
    // Set this views title
    self.title = iPFTLocalizedString(@"iPFT_TITLE_SUBMIT");
    
    // Add BarButtonItems to the navigationbar
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
    
    UIBarButtonItem *buttonSend = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_SEND")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(sendButtonPressed:)];
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:fixSpace, buttonCancel, flexSpace, buttonSend, fixSpace, nil];
    
    [self setToolbarItems:arrayItems];
    
    // Set title and description
    _labelSubmitTitle.text = iPFTLocalizedString(@"iPFT_SUBMIT_TITLE");
    _labelSubmitDesc.text = iPFTLocalizedString(@"iPFT_SUBMIT_DESC");
    [_labelSubmitDesc sizeToFit];
}


#pragma mark - iPFTModule delegate


- (void) sendingFailed:(NSString *)errorDescription {
    
    // Hide the activity indicator
    _viewActivityIndicator.hidden = YES;
    
    // Create an alert view to inform the user about the submission status
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_FEEDBACK_FAILED_TITLE")
                                          message:[NSString stringWithFormat:iPFTLocalizedString(@"iPFT_ALERT_FEEDBACK_FAILED_MSG"), errorDescription]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Add actions to the alert view
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_OK")
                               style:UIAlertActionStyleCancel
                               handler:nil];
    
    
    [alertController addAction:okAction];
    
    // Present alert view
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void) sendingSuccessful {
    
    // Hide the activity indicator
    _viewActivityIndicator.hidden = YES;
    
    // Create an alert view to inform the user about the submission status
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_FEEDBACK_SENT_TITLE")
                                          message:iPFTLocalizedString(@"iPFT_ALERT_FEEDBACK_SENT_MSG")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Add actions to the alert view
    __weak id weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_OK")
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {
                                   // Close feebback tool
                                   [weakSelf cancelButtonPressed:nil];
                               }];

    
    [alertController addAction:okAction];
    
    // Present alert view
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - IBActions


- (IBAction) sendButtonPressed:(id)sender {
    
    // Show the activity indicator
    _viewActivityIndicator.hidden = NO;
    
    // Send native mail
    if ( MODULE_NATIVE_MAIL ) {
        
        iPFTModuleNativeMail *nativeMail = [[iPFTModuleNativeMail alloc] init];
        nativeMail.delegate = self;
        [self addChildViewController:nativeMail];
        [nativeMail send:[self.submitData getDataForSubmission]];
        
        // Hide the activity indicator (We don´t want one in this case)
        _viewActivityIndicator.hidden = YES;
    }
    
    // Send redmine ticket
    else if ( MODULE_REDMINE ) {
        
        iPFTModuleRedmineTicket *redmineTicket = [[iPFTModuleRedmineTicket alloc] init];
        redmineTicket.delegate = self;
        [self addChildViewController:redmineTicket];
        [redmineTicket send:[self.submitData getDataForSubmission]];
    }
}


- (IBAction) cancelButtonPressed:(id)sender {
 
    // Enable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:NO];
    
    // Call super class method
    [super cancelButtonPressed:sender];
}


@end
