# EDWVersionCheckManager

can check updateInfo for appstroe

pod 'EDWVersionCheckManager', '~> 0.0.1'

```objc
[[EDWVersionCheckManager shardedVersionCheckManager] needUpdateWithAppID:@"956441505" WithCallBack:^(EDWVersionCheckManager *manager, BOOL needUpdate) {
        ;
        NSLog(@"version:%@",manager.targetVersion);
        NSLog(@"note:%@",manager.releaseNotes);
    }];
```