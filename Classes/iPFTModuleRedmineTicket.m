//
//  iPFTModuleRedmineTicket.m
//  iPhoneFeedbackTool
//
//  Created by Christian Neumann on 25.07.15.
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

#import "iPFTModuleRedmineTicket.h"


@implementation iPFTModuleRedmineTicket


#pragma mark - Initialization


- (id) init {
    
    self = [super init];
    if ( self ) {
        
        // Set the initial values for the request/response counting
        _responseCount = 0;
        _requestMax = 0;
        _uploads = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma makr - Instance methods


- (void) send:(NSArray *)data {
    
    // Call superclass implementation to take care of basic stuff
    [super send:data];
    
    // Check if we need to upload files
    for ( NSDictionary *dict in data ) {
        
        if ( [dict valueForKey:DATA_KEY] &&
            [dict valueForKey:DATA_VALUE] ) {
            
            // Check if we have an image to submit
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_SCREENSHOT")] ) {
                
                // Update the number of requests
                _requestMax++;
                
                // Set the image
                _submitImage = [dict valueForKey:DATA_VALUE];
                
                continue;
            }
            
            // Attach stacktrace as text files
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_STACKTRACE")] ) {
                
                // Update the number of requests
                _requestMax++;
                
                // Set the stacktrace
                _submitStacktrace = [[dict valueForKey:DATA_VALUE] dataUsingEncoding:NSUTF8StringEncoding];
                
                continue;
            }
            
            // Attach log as text files
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPLOG")] ) {
                
                // Update the number of requests
                _requestMax++;
                
                // Set the stacktrace
                _submitLog = [[dict valueForKey:DATA_VALUE] dataUsingEncoding:NSUTF8StringEncoding];
                
                continue;
            }
        }
    }
    
    
    // Check if we can post the ticket or if we have to upload fiels first
    if ( _responseCount == _requestMax ) {
        
        [self postTicket];
        return;
    }
    
    // Upload the files
    if ( _submitImage ) {
        
        // We can start with the image upload
        [self uploadImage:_submitImage];
    }
    else if ( _submitStacktrace ) {
        
        // When there is no image upload we can upload the stacktrace
        [self uploadTextfile:_submitStacktrace];
    }
}


- (void) uploadImage:(UIImage *)image {
    
    // Get the image data
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    // Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/uploads.json",[self.dictModuleData valueForKey:KEY_API_URL]]]];
    
    // Set the header
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self.dictModuleData valueForKey:KEY_API_APIKEY] forHTTPHeaderField:@"X-Redmine-API-Key"];
    
    // Set the body
    [request setHTTPBody:imageData];
    
    // Send the request
    [self sendRequest:request];
}


- (void) uploadTextfile:(NSData *)textData {
    
    // Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/uploads.json",[self.dictModuleData valueForKey:KEY_API_URL]]]];
    
    // Set the header
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self.dictModuleData valueForKey:KEY_API_APIKEY] forHTTPHeaderField:@"X-Redmine-API-Key"];
    
    // Set the body
    [request setHTTPBody:textData];
    
    // Send the request
    [self sendRequest:request];
}


- (void) postTicket {
    
    // Get the feedback data and create the description (the ticket text)
    NSString *description = @"";
    for ( NSDictionary *dict in self.arraySubmitData ) {
        
        if ( [dict valueForKey:DATA_KEY] &&
            [dict valueForKey:DATA_VALUE] ) {
            
            // Attach image as file
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_SCREENSHOT")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_STACKTRACE")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPLOG")] ) {
                
                continue;
            }
            
            // Add additional linebreaks to format the text
            NSString *linebreak = @"\n";
            
            if ( [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_TIMESTAMP")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_MESSAGE")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_USEREMAIL")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_IOSVERSION")] ||
                [[dict valueForKey:DATA_KEY] isEqualToString:iPFTLocalizedString(@"iPFT_EMAIL_APPBUILD")]) {
                
                linebreak = [linebreak stringByAppendingString:@"\n"];
            }
            
            // Add any other key
            description = [description stringByAppendingFormat:@"%@: %@%@", [dict valueForKey:DATA_KEY], [dict valueForKey:DATA_VALUE], linebreak];
        }
    }
    
    // Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/issues.json",[self.dictModuleData valueForKey:KEY_API_URL]]]];
    
    // Set the header
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[self.dictModuleData valueForKey:KEY_API_APIKEY] forHTTPHeaderField:@"X-Redmine-API-Key"];
    
    // Create the request body
    NSMutableDictionary *issue = [[NSMutableDictionary alloc] init];
    [issue setObject:[self.dictModuleData valueForKey:KEY_API_PROJECT] forKey:@"project_id"];
    [issue setObject:[self.dictModuleData valueForKey:KEY_API_TRACKER] forKey:@"tracker_id"];
    [issue setObject:iPFTLocalizedString(@"iPFT_EMAIL_SUBJECT") forKey:@"subject"];
    [issue setObject:description forKey:@"description"];
    
    // Add uploads
    if ( [_uploads firstObject] ) {
        
        [issue setObject:_uploads forKey:@"uploads"];
    }
    
    NSMutableDictionary *payload = [[NSMutableDictionary alloc] init];
    [payload setObject:issue forKey:@"issue"];
    
    // Set the request body
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:jsonData];
    
    // Send the request
    [self sendRequest:request];
}


- (void) sendRequest:(NSURLRequest *)request {
    
    // Reference to self used in blocks
    __weak id weakSelf = self;
    
    // Send your request asynchronously
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *responseCode, NSData *responseData, NSError *responseError) {
                               
                               // Everythng went fine
                               if ( [responseData length] > 0 && responseError == nil ) {
                                   
                                   //NSLog(@"[iPFT Redmine response] %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                                   
                                   // Count the received response
                                   _responseCount++;
                                   
                                   // We are done uploading and posting the ticket
                                   if ( _responseCount > _requestMax ) {
                                       
                                       // Inform the delegate about sending result
                                       if ( [weakSelf delegate] && [[weakSelf delegate] respondsToSelector:@selector(sendingSuccessful)] ) {
                                           
                                           [[weakSelf delegate] sendingSuccessful];
                                       }
                                   }
                                   
                                   // We still have unsubmitted data
                                   else {
                                       
                                       // Parse response string
                                       NSError *parseError = nil;
                                       NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
                                       
                                       // Ooops...
                                       if ( parseError ) {
                                           
                                           // Inform the delegate about sending result
                                           if ( [weakSelf delegate] && [[weakSelf delegate] respondsToSelector:@selector(sendingFailed:)] ) {
                                               
                                               [[weakSelf delegate] sendingFailed:iPFTLocalizedString(@"iPFT_ERROR_PARSE_FAILED")];
                                           }
                                           return;
                                       }
                                       
                                       // If everything went fine, we have that key in our JSON object
                                       if ( [dictResponse valueForKey:@"upload"] && [[dictResponse valueForKey:@"upload"] valueForKey:@"token"] ) {
                                           
                                           
                                           // Check where we are right now
                                           if ( _responseCount == 1 && ( _requestMax == 1 || _requestMax == 3) ) {
                                               
                                               // We just uploaded image
                                               // Add the token to the uploads data
                                               NSDictionary *file = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                                     [[dictResponse valueForKey:@"upload"] valueForKey:@"token"], @"token",
                                                                     @"screenshot.jpg", @"filename",
                                                                     @"image/jpeg", @"content_type",
                                                                     nil];
                                               
                                               // Add file to uploads array
                                               [_uploads addObject:file];
                                           }
                                           
                                           else if ( ( _responseCount == 1 &&  _requestMax == 2 ) || ( _responseCount == 2 &&  _requestMax == 3 ) ) {
                                               
                                               // We just uploaded the stacktrace
                                               // Add the token to the uploads data
                                               NSDictionary *file = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                                     [[dictResponse valueForKey:@"upload"] valueForKey:@"token"], @"token",
                                                                     @"stacktrace.txt", @"filename",
                                                                     @"text/plain", @"content_type",
                                                                     nil];
                                               
                                               // Add file to uploads array
                                               [_uploads addObject:file];
                                           }
                                           
                                           else {
                                               
                                               // We just uploaded the log
                                               // Add the token to the uploads data
                                               NSDictionary *file = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                                     [[dictResponse valueForKey:@"upload"] valueForKey:@"token"], @"token",
                                                                     @"log.txt", @"filename",
                                                                     @"text/plain", @"content_type",
                                                                     nil];
                                               
                                               // Add file to uploads array
                                               [_uploads addObject:file];
                                           }
                                           
                                           // Next step
                                           // Post the ticket
                                           if ( _responseCount == _requestMax ) {
                                               
                                               [weakSelf postTicket];
                                           }
                                           
                                           // Upload the stacktrace
                                           else if ( _responseCount == 1 && _requestMax == 3 ) {
                                               
                                               [weakSelf uploadTextfile:_submitStacktrace];
                                           }
                                           
                                           // Upload the log
                                           else {
                                               
                                               [weakSelf uploadTextfile:_submitLog];
                                           }
                                           
                                       }
                                   }
                               }
                               
                               // Connection failed due to data error
                               else if ( [responseData length] == 0 && responseError == nil ){
                                   
                                  // NSLog(@"[iPFT Redmine ERROR] %@",iPFTLocalizedString(@"iPFT_ERROR_COULD_NOT_READ_DATA"));
                                   
                                   // Inform the delegate about sending result
                                   if ( [weakSelf delegate] && [[weakSelf delegate] respondsToSelector:@selector(sendingFailed:)] ) {
                                       
                                       [[weakSelf delegate] sendingFailed:iPFTLocalizedString(@"iPFT_ERROR_COULD_NOT_READ_DATA")];
                                   }
                               }
                               
                               // Connection failed due to connectino timeout
                               else if ( responseError != nil && responseError.code == NSURLErrorTimedOut ){
                                   
                                  // NSLog(@"[iPFT Redmine ERROR] %@",responseError.localizedDescription);
                                   
                                   // Inform the delegate about sending result
                                   if ( [weakSelf delegate] && [[weakSelf delegate] respondsToSelector:@selector(sendingFailed:)] ) {
                                       
                                       [[weakSelf delegate] sendingFailed:responseError.localizedDescription];
                                   }
                               }
                               
                               // Any other error
                               else if ( responseError != nil ) {
                                   
                                 //  NSLog(@"[iPFT Redmine ERROR] %@",responseError.localizedDescription);
                                   
                                   // Inform the delegate about sending result
                                   if ( [weakSelf delegate] && [[weakSelf delegate] respondsToSelector:@selector(sendingFailed:)] ) {
                                       
                                       [[weakSelf delegate] sendingFailed:responseError.localizedDescription];
                                   }
                               }
                           }];
}


@end
