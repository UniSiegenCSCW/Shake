//
//  iPFTModuleNativeMail.m
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

#import "iPFTModuleNativeMail.h"

@implementation iPFTModuleNativeMail


#pragma mark - Instance methods


- (void) send:(NSArray *)data {
    
    // Call superclass implementation to take care of the basic stuff
    [super send:data];
    
    // Check if there is an email account configured that we can use to send the mail from
    if ( ![MFMailComposeViewController canSendMail] ) {
        
        // Inform the user that there is no mail account
        [self alertMailNotConfigured];
        _sending = NO;
        return;
    }
    
    // Init and config the native mail composer
    _mailComposer = [[MFMailComposeViewController alloc] init];
    _mailComposer.mailComposeDelegate = self;
    
    // Add recipient
    if ( [self.dictModuleData valueForKey:KEY_RECIPIENT_NAME] && [self.dictModuleData valueForKey:KEY_RECIPIENT_EMAIL] ) {
        
        NSString *name = [self.dictModuleData valueForKey:KEY_RECIPIENT_NAME];
        NSString *email = [self.dictModuleData valueForKey:KEY_RECIPIENT_EMAIL];
        NSString *recipient = [NSString stringWithFormat:@"%@ <%@>", name, email];
        [_mailComposer setToRecipients:[NSArray arrayWithObjects:recipient, nil]];
    }
    
    // Create the email subject
    NSString *appname = @"";
    
    for ( NSDictionary *dict in data ) {
        
        if ( [dict valueForKey:DATA_KEY] &&
            [dict valueForKey:DATA_VALUE] &&
            [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPNAME")] ) {
            
            appname = [dict valueForKey:DATA_VALUE];
            
            break;
        }
    }
    
    NSString *subject = [NSString stringWithFormat:@"%@: %@", iPFTLocalizedString(@"iPFT_EMAIL_SUBJECT"), appname];
    [_mailComposer setSubject:subject];
    
    // Create the email body
    NSString *body = @"";
    
    for ( NSDictionary *dict in data ) {
     
        if ( [dict valueForKey:DATA_KEY] &&
            [dict valueForKey:DATA_VALUE] ) {
            
            // Attach image as file
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_SCREENSHOT")] ) {
                
                [_mailComposer addAttachmentData:UIImageJPEGRepresentation([dict valueForKey:DATA_VALUE], 1) mimeType:[dict valueForKey:DATA_TYPE] fileName:@"screenshot.jpg"];
                
                continue;
            }
            
            // Attach stacktrace as text files
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_STACKTRACE")] ) {
    
                NSData *textData = [[dict valueForKey:DATA_VALUE] dataUsingEncoding:NSUTF8StringEncoding];
                [_mailComposer addAttachmentData:textData mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"stacktrace.txt"]];
                
                
                continue;
            }
            
            // Attach log as text files
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPLOG")] ) {
                
                NSData *textData = [[dict valueForKey:DATA_VALUE] dataUsingEncoding:NSUTF8StringEncoding];
                [_mailComposer addAttachmentData:textData mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"log.txt"]];
                
                
                continue;
            }
            
            // Add additional linebreaks to format the mail
            NSString *linebreak = @"\n";
            
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_TIMESTAMP")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_MESSAGE")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_USEREMAIL")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_IOSVERSION")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPBUILD")]) {
                
                linebreak = [linebreak stringByAppendingString:@"\n"];
            }
            
            // Add any other key
            body = [body stringByAppendingFormat:@"%@: %@%@", [dict valueForKey:DATA_KEY], [dict valueForKey:DATA_VALUE], linebreak];
        }
    }
    
    [_mailComposer setMessageBody:body isHTML:NO];
    
    
    // Show the native mail composer
    if ( self.parentViewController ) {
        
        [self.parentViewController presentViewController:_mailComposer animated:YES completion:nil];
    }
}


- (void) alertMailNotConfigured {
    
    // Inform the user that there is no email account configured
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:iPFTLocalizedString(@"iPFT_ALERT_NOMAIL_TITLE")
                                          message:iPFTLocalizedString(@"iPFT_ALERT_NOMAIL_MSG")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    // Add actions to the alert view
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_OK")
                               style:UIAlertActionStyleCancel
                               handler:nil];
    
    [alertController addAction:okAction];
    
    // Present alert view
    if ( self.parentViewController ) {

        [self.parentViewController presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - MFMailComposeViewController delegate


- (void) mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    
    // Close MailConposeViewController
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    // Check the operation result
    if ( result ) {
    
        // Inform the delegate about sending result
        if ( self.delegate && [self.delegate respondsToSelector:@selector(sendingSuccessful)] ) {
    
            [self.delegate sendingSuccessful];
        }
    }

    // Check for errors
    if ( error ) {
        
        // Inform the delegate about sending result
        if ( self.delegate && [self.delegate respondsToSelector:@selector(sendingFailed:)] ) {
        
            [self.delegate sendingFailed:error.localizedDescription];
        }
    }
    
    // Set flag to NO, so we can send again
    _sending = NO;
}

@end
