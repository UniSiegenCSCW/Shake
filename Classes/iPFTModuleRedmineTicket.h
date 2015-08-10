//
//  iPFTModuleRedmineTicket.h
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

#import "iPFTModule.h"

#define KEY_API_URL     @"apiURL"       /**< URL for the redmine rest api */
#define KEY_API_TRACKER @"apiTrackerId" /**< Tracker ID for the redmine rest api */
#define KEY_API_PROJECT @"apiProjectId" /**< Project ID for the redmine rest api */
#define KEY_API_APIKEY  @"apiKey"       /**< Redmine API Key for the redmine rest api */

/**
	This class provides functionality to post tickets directly to the redmine project management system
 */
@interface iPFTModuleRedmineTicket : iPFTModule {
    
    __block int _requestMax; /**< Numbre of requests to be answered before ticket can be posted */
    __block int _responseCount; /**< Numbre of requests that have been answered */
    __block NSData *_submitStacktrace; /**< Stacktrace to be sent */
    __block NSData *_submitLog; /**< Log to be sent */
    __block UIImage *_submitImage; /**< Image to be sent */
    __block NSMutableArray *_uploads; /**< Array that stores the upload tokens for the redmine issue */
}

#pragma mark - Properties

#pragma mark - Instance methods

/**
	Uploads the screenshot to the redmine system
	@param image The image to upload
 */
- (void) uploadImage:(UIImage *)image;

/**
	Uploads a textfile to the redmine system
	@param textData The data to upload
 */
- (void) uploadTextfile:(NSData *)textData;

/**
	Posts the ticket to the redmine system
 */
- (void) postTicket;

/**
	Send the request and take care of the result
	@param request The reqesut to send
 */
- (void) sendRequest:(NSURLRequest *)request;

#pragma mark - IBActions

@end
