//
//  Notif.h
//  SnatterN
//
//  Created by Souvik Ray on 12/31/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notif : NSObject<NSCopying>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) int notif_id;

@end

@interface NotifAns : Notif

//@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *ques;
@property (nonatomic, copy) NSString *ans;
//@property (nonatomic, assign) int notif_id;

@end
