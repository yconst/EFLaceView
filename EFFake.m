//
//  EFFake.m
//  EFLaceView
//
//  Created by MacBook Pro ef on 06/08/06.
//  Copyright 2006 Edouard FISCHER. All rights reserved.
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//	-	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//	-	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//	-	Neither the name of Edouard FISCHER nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "EFFake.h"

NSString *const cTitleColor = @"titleColor";
NSString *const cColorAsData = @"colorAsData";

@implementation EFFake
+ (NSArray *)keysForNonBoundsProperties
{
	static NSArray *keys = nil;
    if (!keys)
    {
		keys = @[@"tag",@"inputs",@"outputs",@"title",cTitleColor,@"verticalOffset",@"originX",@"originY",@"width",@"height"];
    }
    return keys;
}


- (NSColor *)titleColor
{
    [self willAccessValueForKey:cTitleColor];
    NSColor *color = [self primitiveValueForKey:cTitleColor];
    [self didAccessValueForKey:cTitleColor];
    if (color == nil) {
        NSData *colorData = [self valueForKey:cColorAsData];
		if (colorData == nil) {
            NSColor *defaultColor = [NSColor colorWithWhite:1.0 alpha:0.9];
			[self setValue:[NSKeyedArchiver archivedDataWithRootObject:defaultColor]
					forKey:cColorAsData];
				colorData = [self valueForKey:cColorAsData];
		}
        if (colorData != nil) {
            color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            [self setPrimitiveValue:color forKey:cTitleColor];
        }
    }
    return color;
} 

- (void)setTitleColor:(NSColor *)aColor
{
    [self willChangeValueForKey:cTitleColor];
    [self setPrimitiveValue:aColor forKey:cTitleColor];
    [self didChangeValueForKey:cTitleColor];
    [self setValue:[NSKeyedArchiver archivedDataWithRootObject:aColor]
			forKey:cColorAsData];
} 

@end
