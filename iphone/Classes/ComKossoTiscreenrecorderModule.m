/**
 * TiScreenRecorder
 *
 * Created by Kosso
 * Copyright (c) 2016 . All rights reserved.
 */

#import "ComKossoTiscreenrecorderModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"


@implementation ComKossoTiscreenrecorderModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"7edbe984-c43b-4e99-af02-57f4f17e3b6e";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.kosso.tiscreenrecorder";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];

    [super startup];
    
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];

	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
    [recorder release];
    
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)startRecording:(id)args
{

    NSLog(@"[INFO] start");
    
    ASScreenRecorder *_recorder = [ASScreenRecorder sharedInstance];
    if (!_recorder.isRecording) {
        [_recorder startRecording];
    }
    
}

-(void)stopRecording:(id)args
{
    
    NSLog(@"[INFO] stop");

    
    ASScreenRecorder *_recorder = [ASScreenRecorder sharedInstance];
    if (!_recorder.isRecording) {
        return;
    }
    
    [_recorder stopRecordingWithCompletion:^{
        NSLog(@"[INFO] recording done and saved in camera roll");
        // Fire 'done' event
    }];
    
    
}

-(BOOL)isRecording:(id)args
{
    
    ASScreenRecorder *_recorder = [ASScreenRecorder sharedInstance];
    NSLog(@"[INFO] isRecording  %d", _recorder.isRecording);
    return _recorder.isRecording;
    
}



@end
