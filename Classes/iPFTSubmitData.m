//
//  iPFTSubmitData.m
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

#import "iPFTSubmitData.h"


@implementation iPFTSubmitData


@synthesize stacktrace = _stacktrace;
@synthesize log = _log;
@synthesize timestamp = _timestamp;
@synthesize screenshot = _screenshot;
@synthesize annotatedScreenshot = _annotatedScreenshot;
@synthesize message = _message;
@synthesize arrayAnnotations = _arrayAnnotations;
@synthesize appName = _appName;
@synthesize appVersion = _appVersion;
@synthesize appBuild = _appBuild;
@synthesize iosVersion = _iosVersion;


#pragma mark - Initialization


- (id) init {
    
    self = [super init];
    if ( self ) {
        
        // Set default values
        _stacktrace = [self fetchStacktrace];
        _log = [self fetchApplicationLog];
        _timestamp = [self fetchTimestamp];
        _annotatedScreenshot = nil;
        
        // Retrieve the apps name and version details
        NSBundle *bundle = [NSBundle mainBundle];
        NSDictionary *info = [bundle infoDictionary];
        _appName = [info objectForKey:(NSString *)kCFBundleNameKey];
        _appVersion = [info objectForKey:@"CFBundleShortVersionString"];
        _appBuild = [info objectForKey:(NSString *)kCFBundleVersionKey];
        _iosVersion = [[UIDevice currentDevice] systemVersion];
        
        // Take a screenshot
        [self fetchScreenshot];
        
        // Initialize arrays
        _arrayAnnotations = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - Instance methods


- (void) fetchScreenshot {
    
    // Get a reference to the main window and capture a screenshot
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *view = window.rootViewController.view;
    _screenshot = [iPFTSubmitData captureView:view];
    
    // Play system sound to let the user know he took a snapshot
    AudioServicesPlaySystemSound(1108);
    
    // Vibrate the phone to give some extra physical feedback
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


- (void) fetchAnnotatedScreenshot:(UIView *)view {

    _annotatedScreenshot = [iPFTSubmitData captureView:view];
}


+ (UIImage *) captureView:(UIView *)view {
    
    // Create graphics context
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    
    // Draw the view
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    // Fetch an UIImage representation of the context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (NSString *) fetchStacktrace {
    
    // Retrieve and return the current stacktrace
    return [NSString stringWithFormat:@"%@",[NSThread callStackSymbols]];
}


// This code is based on: http://www.cocoanetics.com/2011/03/accessing-the-ios-system-log/
- (NSString *) fetchApplicationLog {
    
    // Retrieve and return the current application log
    aslmsg q, m;
    int i;
    const char *key, *val;
    
    q = asl_new(ASL_TYPE_QUERY);
    
    NSString* output = @"";
    
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = asl_next(r)))
    {
        NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
        
        for (i = 0; (NULL != (key = asl_key(m, i))); i++)
        {
            NSString *keyString = [NSString stringWithUTF8String:(char *)key];
            
            val = asl_get(m, key);
            
            NSString *string = val?[NSString stringWithUTF8String:val]:@"";
            [tmpDict setObject:string forKey:keyString];
        }
        
        output = [output stringByAppendingString:[self formatAppLogEntry:tmpDict]];
    }
    asl_free(r);
    
    return output;
}


- (NSString *) formatAppLogEntry:(NSDictionary *)logEntry {

    // Initialize the return string
    NSString *formatString = @"";
    
    // Build the return string
    if ( [logEntry valueForKey:@"CFLog Local Time"] ) {
       
        formatString = [formatString stringByAppendingString:[NSString stringWithFormat:@"[%@ %@]",
                                                              [logEntry valueForKey:@"CFLog Local Time"],
                                                              [logEntry valueForKey:@"Sender"]]];
    }
    
    if ( [logEntry valueForKey:@"Message"] ) {
        
        formatString = [formatString stringByAppendingString:[NSString stringWithFormat:@" %@",[logEntry valueForKey:@"Message"]]];
    }
    
    formatString = [formatString stringByAppendingString:@"\n"];
   
    return formatString;
}


- (NSNumber *) fetchTimestamp {
    
    // Create and return a current timestamp
    return [NSNumber numberWithInt:[[[NSDate alloc] init] timeIntervalSince1970]];
}


- (NSArray *) getDataForSubmission {
    
    // Create the array
    NSMutableArray *arrayData = [[NSMutableArray alloc] init];
    
    // Add timestamp
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[_timestamp intValue]];
    [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                          iPFTLocalizedString(@"iPFT_EMAIL_TIMESTAMP"), DATA_KEY,
                          [dateFormatter stringFromDate:date],DATA_VALUE,
                          nil]];
    
    // Add app name
    [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                          iPFTLocalizedString(@"iPFT_EMAIL_APPNAME"), DATA_KEY,
                          _appName, DATA_VALUE,
                          nil]];
    
    // Add app version
    [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                          iPFTLocalizedString(@"iPFT_EMAIL_APPVERSION"), DATA_KEY,
                          _appVersion, DATA_VALUE,
                          nil]];
    
    // Add app build
    [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                          iPFTLocalizedString(@"iPFT_EMAIL_APPBUILD"), DATA_KEY,
                          _appBuild, DATA_VALUE,
                          nil]];
    
    // iOS Version
    [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                          iPFTLocalizedString(@"iPFT_EMAIL_IOSVERSION"), DATA_KEY,
                          _iosVersion, DATA_VALUE,
                          nil]];
    
    // Add contact details
    if ( [iPFTPersistence getOption:KEY_OPTION_NAME] ) {
        
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_USERNAME"), DATA_KEY,
                              [iPFTPersistence getSenderName],DATA_VALUE,
                              nil]];
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_USEREMAIL"), DATA_KEY,
                              [iPFTPersistence getSenderEmail],DATA_VALUE,
                              nil]];
    }
    
    // Add message
    if ( [iPFTPersistence getOption:KEY_OPTION_MESSAGE] ) {
        
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_MESSAGE"), DATA_KEY,
                              _message,DATA_VALUE,
                              nil]];
    }
    
    // Add stacktrace and log
    if ( [iPFTPersistence getOption:KEY_OPTION_STACKTRACE] ) {
        
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_STACKTRACE"), DATA_KEY,
                              _stacktrace,DATA_VALUE,
                              nil]];
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_APPLOG"), DATA_KEY,
                              _log,DATA_VALUE,
                              nil]];
    }
    
    // Add annotations
    if ( [iPFTPersistence getOption:KEY_OPTION_SCREENSHOT] ) { // We only need them if we include the screenshot
        
        for ( iPFTAnnotationView *annotation in _arrayAnnotations ) {
            
            [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                                  [NSString stringWithFormat:iPFTLocalizedString(@"iPFT_EMAIL_ANNOTATION"), [annotation.uniqueID intValue]], DATA_KEY,
                                  annotation.details,DATA_VALUE,
                                  nil]];
        }
    }
    
    // Add screenshot
    if ( [iPFTPersistence getOption:KEY_OPTION_SCREENSHOT] ) { // We only need them if we include the screenshot
        
        [arrayData addObject:[[NSDictionary alloc] initWithObjectsAndKeys:
                              iPFTLocalizedString(@"iPFT_EMAIL_SCREENSHOT"), DATA_KEY,
                              @"image/jpeg", DATA_TYPE,
                              _annotatedScreenshot,DATA_VALUE,
                              nil]];
    }
    
    return arrayData;
}


#pragma mark - Setters and getters with custom behaviour


- (void) setSenderName:(NSString *)name {
    
    // Write new name to user defaults
    [iPFTPersistence setSenderName:name];
}


- (void) setSenderEmail:(NSString *)email {
    
    // Write email to user defautls
    [iPFTPersistence setSenderEmail:email];
}


- (NSString *) senderName {
    
    // Read sender name from user defaults
    return [iPFTPersistence getSenderName];
}

- (NSString *) senderEmail {
    
    // Read sender email from user deafaults
    return [iPFTPersistence getSenderEmail];
}

@end
