//
//  iPFTConfig.h
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

#ifndef iPhoneFeedbackToolExample_iPFTConfig_h
#define iPhoneFeedbackToolExample_iPFTConfig_h

// Setup active submit module
// If you have more than one module set to be active, the first one found will be used
#define MODULE_NATIVE_MAIL 1 /**< Native mail module */
#define MODULE_REDMINE     0 /**< Redmine ticket module */

// Setup how often the info views are shown
#define ALWAYS_SHOW_INFO_VIEW            0 /**< Main info view status */
#define ALWAYS_SHOW_ANNOTATION_INFO_VIEW 0 /**< Main info view status */

#endif
