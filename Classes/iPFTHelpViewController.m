//
//  iPFTHelpViewController.m
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

#import "iPFTHelpViewController.h"


@implementation iPFTHelpViewController


@synthesize webView = _webView;
@synthesize contentHTML = _contentHTML;


#pragma mark - Instance methods


- (void) initData {
    
    [super initData];
    
    // Set this views title
    self.title = iPFTLocalizedString(@"iPFT_TITLE_HELP");
    
    // Add BarButtonItems to the toolbar
    UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                              target:nil
                                                                              action:nil];
    fixSpace.width = 10.0;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle:iPFTLocalizedString(@"iPFT_BUTTON_DONE")
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(cancelButtonPressed:)];
    NSArray *arrayItems = [[NSArray alloc] initWithObjects:flexSpace, buttonDone, fixSpace, nil];
    [self setToolbarItems:arrayItems];
    
    // Make sure navigation bar and toolbar are not hiding any content
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Setup the webview
    _path = [[NSBundle mainBundle] bundlePath];
    _baseURL = [NSURL fileURLWithPath:_path];
    NSBundle *iPFTBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iPhoneFeedbackTool.bundle"]];
    _cssPath = [iPFTBundle pathForResource:CSS_iPFT ofType:@"css"];
    _cssString = [NSString stringWithContentsOfFile:_cssPath encoding:NSUTF8StringEncoding error:nil];
    _preHTML = [NSString stringWithFormat:@"<html><head><style type=\"text/css\">%@</style>"
                @"</head><body>",_cssString];
    _postHTML = @"</body></html>";
    _webView.opaque = NO;
    _webView.layer.cornerRadius = 7;
    _webView.layer.masksToBounds = YES;
    
    // Load the actual content
    [self loadContentHTML];
    NSString *finalHTML = [NSString stringWithFormat:@"%@%@%@",_preHTML,_contentHTML,_postHTML];
    
    // Display content in the webview
    [_webView loadHTMLString:finalHTML baseURL:_baseURL];
}


- (void) loadContentHTML {
    
    // Load the content for this view from the iPFT bundle
    NSBundle *iPFTBundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"iPhoneFeedbackTool.bundle"]];
    NSString *htmlFile = [iPFTBundle pathForResource:@"help" ofType:@"html"];
    self.contentHTML = [NSString stringWithFormat:[NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil],iPFT_VERSION];
}


#pragma mark - IBActions


@end
