//
//  NSString(ToHex).m
//  EnglishSentence_Block
//
//  Created by liqun on 13-5-28.
//  Copyright (c) 2013年 block. All rights reserved.
//

#import "NSString(ToHex).h"

@implementation NSString (ToHex)
-(NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
@end
