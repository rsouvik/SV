//
//  Notif.m
//  SnatterN
//
//  Created by Souvik Ray on 12/31/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "Notif.h"

@implementation Notif

-(id) copyWithZone: (NSZone *) zone
{
    Notif *notifcopy = [[Notif allocWithZone:zone] init];
    _type=@"";
    _notif_id=0;
    
    return notifcopy;
}
@end

@implementation NotifAns

-(id) copyWithZone: (NSZone *) zone
{
    NotifAns *notifcopy = [[NotifAns allocWithZone:zone] init];
    _ques=@"";
    _ans=@"";
   
    return notifcopy;
}
@end
