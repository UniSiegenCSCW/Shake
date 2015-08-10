//
//  iPFTModuleNativeMail.h
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

#import "iPFTModule.h"
#import <MessageUI/MessageUI.h>

#define KEY_RECIPIENT_NAME @"recipientName" /**< Recipient name */
#define KEY_RECIPIENT_EMAIL @"recipientEmail" /**< Recipient email */

/**
	This class sends feedback using the native mail app
 */
@interface iPFTModuleNativeMail : iPFTModule <MFMailComposeViewControllerDelegate> {
    
    MFMailComposeViewController *_mailComposer; /**< Controller for the native email submission */
}

#pragma mark - Properties

#pragma mark - Instance methods

/**
	Inform the user about his mail accounts not being configured properly to send native mails with this tool
 */
- (void) alertMailNotConfigured;

#pragma mark - IBActions

@end
