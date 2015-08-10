//
//  iPFTPersistence.m
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 10.06.15.
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

#import "iPFTPersistence.h"


@implementation iPFTPersistence


#pragma mark - Static methods


+ (void) setSenderName:(NSString *)name {

    // Write sender name to user defaults
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:KEY_SENDER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *) getSenderName {
    
    // Read sender name from user defaults
    return ( [[NSUserDefaults standardUserDefaults] valueForKey:KEY_SENDER_NAME] ) ? [[NSUserDefaults standardUserDefaults] valueForKey:KEY_SENDER_NAME] : @"";
}


+ (void) setSenderEmail:(NSString *)email {
    
    // Write sender email to user defaults
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:KEY_SENDER_EMAIL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *) getSenderEmail {
    
    // Read sender email from user defaults
    return ( [[NSUserDefaults standardUserDefaults] valueForKey:KEY_SENDER_EMAIL] ) ? [[NSUserDefaults standardUserDefaults] valueForKey:KEY_SENDER_EMAIL] : @"";
}


+ (void) setInfoHasBeenShown {
    
    // Write status to user defaults
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_INFO_HAS_BEEN_SHOWN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL) hasInfoBeenShown {
    
    // Read status from user defaults
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_INFO_HAS_BEEN_SHOWN];
}


+ (void) setAnnotationInfoHasBeenShown {
    
    // Write status to user defaults
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_ANNOTATION_INFO_HAS_BEEN_SHOWN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL) hasAnnotationInfoBeenShown {
    
    // Read status from user defaults
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_ANNOTATION_INFO_HAS_BEEN_SHOWN];
}


+ (void) setOption:(NSString *)optionKey value:(BOOL)value {
    
    // Write option to user defaults
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:optionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL) getOption:(NSString *)optionKey {
    
    // Check if an option was saved earlier and set default values
    if ( [[NSUserDefaults standardUserDefaults] objectForKey:optionKey] == nil ) {
        
        // Set default value
        [iPFTPersistence setOption:optionKey value:YES];
    }
    
    // Read option value from user defaults
    return [[NSUserDefaults standardUserDefaults] boolForKey:optionKey];
}


// Variable that blocks
static BOOL blockShakeGesture = NO;


+ (void) setBlockShakeGesture:(BOOL)value {
    
    // Write option to user defaults
    blockShakeGesture = value;
}


+ (BOOL) getBlockShakeGesture {
    
    // Read option value from user defaults
    return blockShakeGesture;
}


@end
