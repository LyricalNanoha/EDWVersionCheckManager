//
//  VersionCheckManager.m
//  ttjd
//
//  Created by Edward on 17/3/14.
//  Copyright © 2017年 yizixuan. All rights reserved.
//

#import "EDWVersionCheckManager.h"



@implementation EDWVersionCheckManager


+(EDWVersionCheckManager *) shardedVersionCheckManager{
    static EDWVersionCheckManager * versionCheckManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        versionCheckManager = [[super allocWithZone:nil] init];
    });
    return versionCheckManager;
    
}

- (void) needUpdateWithAppID:(NSString *)appID WithCallBack:(EDWVersionCheckManagerFinishedCallBack)callBack{
    
    
    self.storeAppID = appID;
    if (self.callBack) {
        return;
    }
    
    self.callBack = callBack;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    
    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.releaseNotes = [[[dic objectForKey:@"results" ] firstObject]objectForKey:@"releaseNotes"];
            self.targetVersion = [[[dic objectForKey:@"results"] firstObject] objectForKey:@"version"];
            
            self.needUpdate = [[self class] judgeNeedUpdateWithCurrentVersion:nowVersion andNewVersion:self.targetVersion];
            self.callBack(self,self.needUpdate);
            self.callBack = nil;
            
        }else{
            self.callBack(self,NO);
            self.callBack = nil;
        }
    }];
    
    //开始任务
    [task resume];
}

+ (BOOL) judgeNeedUpdateWithCurrentVersion:(NSString *)currentVersion andNewVersion:(NSString *)newVersion{
    if (!newVersion) {
        return NO;
    }
    
    NSArray * current = [currentVersion componentsSeparatedByString:@"."];
    NSArray * new = [newVersion componentsSeparatedByString:@"."];
    
    NSInteger min = MIN(current.count, new.count);
    
    
    for (int i =0 ;i<min; i++) {
        if ([current[i] integerValue] <[new[i] integerValue]) {
            return YES;
        }else if ([current[i] integerValue] > [new[i] integerValue]) {
            return NO;
        }else{
            continue;
        }
    }
    
    if (new.count > current.count) {
        return YES;
    }
    return NO;
}


@end
