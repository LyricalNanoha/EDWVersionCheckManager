//
//  VersionCheckManager.h
//  ttjd
//
//  Created by Edward on 17/3/14.
//  Copyright © 2017年 yizixuan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EDWVersionCheckManager;
typedef void (^EDWVersionCheckManagerFinishedCallBack)(EDWVersionCheckManager * manager,BOOL needUpdate);

@interface EDWVersionCheckManager : NSObject

@property (copy,nonatomic) EDWVersionCheckManagerFinishedCallBack callBack;

+(EDWVersionCheckManager *) shardedVersionCheckManager;

- (void) needUpdateWithAppID:(NSString *)appID WithCallBack:(EDWVersionCheckManagerFinishedCallBack)callBack;

@property (copy,nonatomic) NSString * releaseNotes;

@property (copy,nonatomic) NSString * targetVersion;

@property (assign,nonatomic) BOOL needUpdate;

@property (copy,nonatomic) NSString * storeAppID;

@end
