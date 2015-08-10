//
//  iPFTPersistence.h
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

#import <Foundation/Foundation.h>

#define KEY_SENDER_NAME @"sender_name" /**< Key for the senders name */
#define KEY_SENDER_EMAIL @"sender_email" /**< Key for the senders email */
#define KEY_INFO_HAS_BEEN_SHOWN @"infohasbeenshown" /**< Key for the info view status */
#define KEY_ANNOTATION_INFO_HAS_BEEN_SHOWN @"annotationinfohasbeenshown" /**< Key for the annotation info view status */
#define KEY_OPTION_NAME @"optionName" /**< Key for the contact detail option */
#define KEY_OPTION_SCREENSHOT @"optionScreenshot" /**< Key for the screenshot option */
#define KEY_OPTION_MESSAGE @"optionMessage" /**< Key for the message option */
#define KEY_OPTION_STACKTRACE @"optionStacktrace" /**< Key for the stacktrace log option */


/**
	This class takes care of the feedback tools persistent data
 */
@interface iPFTPersistence : NSObject

#pragma mark - Static methods

/**
	Write sender name to user defaults
	@param name The name to save
 */
+ (void) setSenderName:(NSString *)name;

/**
	Read the sender name from user defaults
	@returns Sender name as string
 */
+ (NSString *) getSenderName;

/**
	Write sender email to user defaults
	@param email The email to save
 */
+ (void) setSenderEmail:(NSString *)email;

/**
	Read sender email from user defaults
	@returns Sender email as NSString
 */
+ (NSString *) getSenderEmail;

/**
	Saves information, that the info view has been shown
 */
+ (void) setInfoHasBeenShown;

/**
	Provides information about the current info view status. The info view is supposed to be shown only on first start up of the tool.
	@returns True, if the user already saw the info view on first start
 */
+ (BOOL) hasInfoBeenShown;

/**
	Saves information, that the annotation info view has been shown
 */
+ (void) setAnnotationInfoHasBeenShown;

/**
	Provides information about the current annotation info view status. The info view is supposed to be shown only on first presentation of the annotation view.
	@returns True, if the user already saw the annotation info view
 */
+ (BOOL) hasAnnotationInfoBeenShown;

/**
	Sets the value for a submission option. These options define, which data will be included in the submission to the developer team
	@param optionKey Key of the option as a unique identifier
	@param value YES / NO value of the option
 */
+ (void) setOption:(NSString *)optionKey value:(BOOL)value;

/**
	Returns the current state of the given option identified by the optionKey
	@param optionKey Key of the option as a unique identifier
	@returns Current state as BOOL
 */
+ (BOOL) getOption:(NSString *)optionKey;

/**
	Blocks the processing of shake events. Useful when the tool is already active
	@param value BOOL defining the current status
 */
+ (void) setBlockShakeGesture:(BOOL)value;

/**
	Read current status
	@returns Current status as BOOL
 */
+ (BOOL) getBlockShakeGesture;

@end
