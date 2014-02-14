//
//  Post.m
//  SnatterN
//
//  Created by Souvik Ray on 1/14/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "Post.h"

@implementation Post

-(id) copyWithZone: (NSZone *) zone
{
    Post *postcopy = [[Post allocWithZone:zone] init];
    _QUESTXT = @"";
    return postcopy;
}

@end
