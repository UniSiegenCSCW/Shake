//
//  iPFTNavigationController.h
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

#import <UIKit/UIKit.h>

/**
	Custom navigation controller to support forced interface orientations
 */
@interface iPFTNavigationController : UINavigationController

#pragma mark - Properties

@property (nonatomic, strong) UIImage *imageParentView; /**< Image to be displayed in the background to make the blur work as expected */
@property (nonatomic, strong) UIImageView *imageViewBackground; /**< ImageView to hold the abckground image */

#pragma mark - Instance methods

/**
	General settings for this view controller
 */
- (void) initData;

@end
