//
//  iPFTSubmitData.h
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

#import <UIKit/UIKit.h>
#import "iPFTGlobal.h"
#import <AudioToolbox/AudioToolbox.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import "ASL.h"
#import "iPFTPersistence.h"
#import "iPFTAnnotationView.h"

#define DATA_KEY @"data_key" /**< Key for the name of the data entry */
#define DATA_VALUE @"data_value" /**< Key for the value of the data entry */
#define DATA_TYPE @"data_type" /**< Key for the data type */

/**
	This class provides all data for feedback submission
 */
@interface iPFTSubmitData : NSObject

#pragma mark - Properties

@property (nonatomic, strong) NSString *stacktrace; /**< Stacktrace snapshot captured on initialization */
@property (nonatomic, strong) NSString *log; /**< Application log snapshot captured on initialization */
@property (nonatomic, strong) NSNumber *timestamp; /**< Timestamp created on initialization */
@property (nonatomic, strong) UIImage *screenshot; /**< Feedback screenshot */
@property (nonatomic, strong) UIImage *annotatedScreenshot; /**< Feedback screenshot with annotations */
@property (nonatomic, strong) NSString *message; /**< General feedback message */
@property (nonatomic, strong) NSMutableArray *arrayAnnotations; /**< Array for the annotations */
@property (nonatomic, strong) NSString *appName; /**< Name of the app */
@property (nonatomic, strong) NSString *appVersion; /**< Version of the app */
@property (nonatomic, strong) NSString *appBuild; /**< Build version of the app */
@property (nonatomic, strong) NSString *iosVersion; /**< iOS version of the device */

#pragma mark - Instance methods

/**
	Takes a screenshot of the given view
 */
- (void) fetchScreenshot;

/**
	Takes a screenshot of the given annotated view
    @param view The view to capture
 */
- (void) fetchAnnotatedScreenshot:(UIView *)view;

/**
	Takes a screenshot of the given view
    @param view The view to capture
	@returns The resulting UIImage representation of the view
 */
+ (UIImage *) captureView:(UIView *)view;

/**
	Fetched the current stacktrace and returns it as NSString representation
	@returns The stacktrace
 */
- (NSString *) fetchStacktrace;

/**
	Fetches the current application log and returns it as NSString representation
	@returns The application log
 */
- (NSString *) fetchApplicationLog;

/**
	Formats an application log entry to a readable string
	@param logEntry The log entry to format
	@returns The formatted String
 */
- (NSString *) formatAppLogEntry:(NSDictionary *)logEntry;

/**
	Creates a timestamp (timeinterval in seconds since 1970)
	@returns Timestamp
 */
- (NSNumber *) fetchTimestamp;

/**
	Prepare the data for submission
	@returns NSArray containing the data
 */
- (NSArray *) getDataForSubmission;

@end
