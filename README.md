# EDWVersionCheckManager

can check updateInfo for appstroe

pod 'EDWVersionCheckManager', '~> 0.0.1'

```objc
[[EDWVersionCheckManager shardedVersionCheckManager] needUpdateWithAppID:@"your AppID" WithCallBack:^(EDWVersionCheckManager *manager, BOOL needUpdate) {
        ;
        if (manager.needUpdate) {
            //to do
        }
        NSLog(@"version:%@",manager.targetVersion);
        NSLog(@"note:%@",manager.releaseNotes);
    }];
```
