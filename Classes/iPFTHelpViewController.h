//
//  iPFTHelpViewController.h
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

#import "iPFTBaseViewController.h"
#import "iPhoneFeedbackTool.h"

#define CSS_iPFT @"iPFT" /**< CSS file for hte HTML content */

/**
	This class displays a help view
 */
@interface iPFTHelpViewController : iPFTBaseViewController {
    
    NSString *_path; /**< Path to the MainBundle */
    NSURL *_baseURL; /**< Base URL for the webview */
    NSString *_cssPath; /**< Path to the CSS file */
    NSString *_cssString; /**< HTML code that includes the CSS file */
    NSString *_preHTML; /**< Content enclosing HTML code */
    NSString *_postHTML; /**< Content enclosing HTML code */
}

#pragma mark - Properties

@property (nonatomic, strong) IBOutlet UIWebView *webView; /**< UIWebView holding the content */
@property (nonatomic, strong) NSString *contentHTML; /**< The views content as HTML code */

#pragma mark - Instance Methods

/**
    General configuration for this view
 */
- (void) initData;

/**
	Loads the content
 */
- (void) loadContentHTML;

#pragma mark - IBActions

@end
