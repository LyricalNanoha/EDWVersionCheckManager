# EDWVersionCheckManager
can check updateInfo for appstroe



[[EDWVersionCheckManager shardedVersionCheckManager] needUpdateWithAppID:@"956441505" WithCallBack:^(EDWVersionCheckManager *manager, BOOL needUpdate) {
;
NSLog(@"version:%@",manager.targetVersion);
NSLog(@"note:%@",manager.releaseNotes);
}];
