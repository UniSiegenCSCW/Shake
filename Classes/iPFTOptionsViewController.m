//
//  iPFTMainViewController.m
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

#import "iPFTOptionsViewController.h"


@implementation iPFTOptionsViewController


@synthesize optionName = _optionName;
@synthesize optionScreenshot = _optionScreenshot;
@synthesize optionMessage = _optionMessage;
@synthesize optionStackTrace = _optionStackTrace;
@synthesize labelOptionsDesc = _labelOptionsDesc;
@synthesize labelName = _labelName;
@synthesize labelNameDesc = _labelNameDesc;
@synthesize labelEmailDesc = _labelEmailDesc;
@synthesize labelMessage = _labelMessage;
@synthesize labelMessageDesc = _labelMessageDesc;
@synthesize labelScreenshot = _labelScreenshot;
@synthesize labelScreenshotDesc = _labelScreenshotDesc;
@synthesize labelStacktrace = _labelStacktrace;
@synthesize labelStacktraceDesc = _labelStacktraceDesc;
@synthesize buttonChangeName = _buttonChangeName;
@synthesize buttonViewLog = _buttonViewLog;


#pragma mark - Instance methods


- (void) initData {

    [super initData];
    
    // Set this views title
    self.title = iPFTLocalizedString(@"iPFT_TITLE_OPTIONS");
    
    // Set this views description
    _labelOptionsDesc.text = iPFTLocalizedString(@"iPFT_OPTIONS_DESC");
    CGRect originalFrame = _labelOptionsDesc.frame;
    [_labelOptionsDesc sizeToFit];
    CGRect newFrame = _labelOptionsDesc.frame;
    _labelOptionsDesc.frame = CGRectMake(originalFrame.origin.x, newFrame.origin.y, originalFrame.size.width, newFrame.size.height);
    
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
    
    UIBarButtonItem *buttonNext = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_NEXT")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(nextButtonPressed:)];
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:fixSpace, buttonCancel, flexSpace, buttonNext, fixSpace, nil];
    
    [self setToolbarItems:arrayItems];
    
    // Set the optionKeys
    _optionName.delegate = self;
    [_optionName setEnabled:[iPFTPersistence getOption:KEY_OPTION_NAME]];
    _labelName.text = iPFTLocalizedString(@"iPFT_OPTIONS_NAME");
    _labelNameDesc.text = [iPFTPersistence getSenderName];
    _labelEmailDesc.text = [iPFTPersistence getSenderEmail];
    //[_labelNameDesc sizeToFit];
    [_buttonChangeName setTitle:iPFTLocalizedString(@"iPFT_BUTTON_EDIT") forState:UIControlStateNormal];
    
    _optionScreenshot.delegate = self;
    [_optionScreenshot setEnabled:[iPFTPersistence getOption:KEY_OPTION_SCREENSHOT]];
    _labelScreenshot.text = iPFTLocalizedString(@"iPFT_OPTIONS_SCREENSHOT");
    _labelScreenshotDesc.text = iPFTLocalizedString(@"iPFT_OPTIONS_SCREENSHOT_DESC");
    [_labelScreenshotDesc sizeToFit];
    
    _optionMessage.delegate = self;
    [_optionMessage setEnabled:[iPFTPersistence getOption:KEY_OPTION_MESSAGE]];
    _labelMessage.text = iPFTLocalizedString(@"iPFT_OPTIONS_MESSAGE");
    _labelMessageDesc.text = iPFTLocalizedString(@"iPFT_OPTIONS_MESSAGE_DESC");
    [_labelMessageDesc sizeToFit];
    
    _optionStackTrace.delegate = self;
    [_optionStackTrace setEnabled:[iPFTPersistence getOption:KEY_OPTION_STACKTRACE]];
    _labelStacktrace.text = iPFTLocalizedString(@"iPFT_OPTIONS_STACKTRACE");
    _labelStacktraceDesc.text = iPFTLocalizedString(@"iPFT_OPTIONS_STACKTRACE_DESC");
    [_labelStacktraceDesc sizeToFit];
    [_buttonViewLog setTitle:iPFTLocalizedString(@"iPFT_BUTTON_VIEW") forState:UIControlStateNormal];
}


#pragma mark - iPFTOptionsDelegate


- (void) switchStatus:(id)sender {
    
    // Check if the sender is an iPFTOptionView
    if ( ![sender isKindOfClass:[iPFTOptionView class]] ) return;
    iPFTOptionView *option = (iPFTOptionView *)sender;
    
    // Take further actions depending on the optionViews tag
    switch (option.tag) {
            
        case TAG_OPTION_NAME:
            [iPFTPersistence setOption:KEY_OPTION_NAME
                                                      value:![iPFTPersistence getOption:KEY_OPTION_NAME]];
            [option setEnabled:[iPFTPersistence getOption:KEY_OPTION_NAME]];
            break;
            
        case TAG_OPTION_SCREENSHOT:
            [iPFTPersistence setOption:KEY_OPTION_SCREENSHOT
                                               value:![iPFTPersistence getOption:KEY_OPTION_SCREENSHOT]];
            [option setEnabled:[iPFTPersistence getOption:KEY_OPTION_SCREENSHOT]];
            break;
            
        case TAG_OPTION_MESSAGE:
            [iPFTPersistence setOption:KEY_OPTION_MESSAGE
                                               value:![iPFTPersistence getOption:KEY_OPTION_MESSAGE]];
            [option setEnabled:[iPFTPersistence getOption:KEY_OPTION_MESSAGE]];
            break;
            
        case TAG_OPTION_STACKTRACE:
            [iPFTPersistence setOption:KEY_OPTION_STACKTRACE
                                               value:![iPFTPersistence getOption:KEY_OPTION_STACKTRACE]];
            [option setEnabled:[iPFTPersistence getOption:KEY_OPTION_STACKTRACE]];
            break;
            
        default:
            break;
    }
}


#pragma mark - IBActions


- (IBAction) buttonEditNamePressed:(id)sender {
    
    // Create a dialog to ask the user for new contact details
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_NEWCONTACT_TITLE")
                                          message:iPFTLocalizedString(@"iPFT_ALERT_NEWCONTACT_MSG")
                                          preferredStyle:UIAlertControllerStyleAlert];

    // Add textfields to the dialog
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = iPFTLocalizedString(@"iPFT_CONTACT_ENTER_NAME");
         textField.text = [iPFTPersistence getSenderName];
         [textField setClearButtonMode:UITextFieldViewModeAlways];
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = iPFTLocalizedString(@"iPFT_CONTACT_ENTER_EMAIL");
         textField.text = [iPFTPersistence getSenderEmail];
         [textField setClearButtonMode:UITextFieldViewModeAlways];
     }];
    
    // Add actions to the alert view
    UIAlertAction *cancelAction = [UIAlertAction
                               actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_CANCEL")
                               style:UIAlertActionStyleCancel
                               handler:nil];
    
    __weak id weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_OK")
                                   style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                               {
                                   // Retrieve textfields
                                   UITextField *name = alertController.textFields.firstObject;
                                   UITextField *email = alertController.textFields.lastObject;
                                   
                                   // Store new contact details
                                   [iPFTPersistence setSenderName:name.text];
                                   [iPFTPersistence setSenderEmail:email.text];
                                   
                                   // Display new contact details
                                   [weakSelf labelNameDesc].text = name.text;
                                   [weakSelf labelEmailDesc].text = email.text;
                                   
                               }];

    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    // Present alert view
    [self.parentViewController presentViewController:alertController animated:YES completion:nil];
}


- (IBAction) buttonViewLogPressed:(id)sender {
    
    // Initialize a new help view controller
    iPFTLogViewController *viewLog = [[iPFTLogViewController alloc] initWithNibName:@"iPFTLogViewController" bundle:nil];
    UINavigationController *navLog = [[UINavigationController alloc] initWithRootViewController:viewLog];
    navLog.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    navLog.toolbar.barStyle = UIBarStyleBlackTranslucent;
    navLog.navigationBar.tintColor = [UIColor lightTextColor];
    navLog.toolbar.tintColor = [UIColor lightTextColor];
    [navLog setNavigationBarHidden:NO];
    [navLog setToolbarHidden:NO];
    
    // Data to display in log view controller
    viewLog.submitData = self.submitData;
    
    // Add this to achieve a transparent modal view
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [navLog setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    // Present the modal view
    [self.navigationController presentViewController:navLog animated:YES completion:nil];
}


- (IBAction) nextButtonPressed:(id)sender {

    // Initialize submit view and push it
    iPFTSubmitViewController *viewSubmit = [[iPFTSubmitViewController alloc] initWithNibName:@"iPFTSubmitViewController" bundle:nil];
    viewSubmit.submitData = self.submitData;
    [self.navigationController pushViewController:viewSubmit animated:YES];
}


- (IBAction) cancelButtonPressed:(id)sender {
 
    // Enable processing of further shake gestures
    [iPFTPersistence setBlockShakeGesture:NO];
    
    // Call super class method
    [super cancelButtonPressed:sender];
}


@end
