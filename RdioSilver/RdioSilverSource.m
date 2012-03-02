//
//  RdioSilverSource.m
//  RdioSilver
//
//  Created by Tony Cosentini on 2/22/12.
//

#import "RdioSilverSource.h"
#import "Rdio.h"
#import "RdioDatabase.h"

@implementation RdioSilverSource

@synthesize rdio;
@synthesize collection;

- (id)init
{
    if (self = [super init]) {
        self.rdio = [SBApplication applicationWithBundleIdentifier:@"com.rdio.desktop"];
        self.rdio = [[RdioDatabase alloc] init];
        [self.rdio loadLibrary];
    }
    return self;
}

- (BOOL)indexIsValidFromDate:(NSDate *)indexDate forEntry:(NSDictionary *)theEntry
{
	return NO;
}

- (NSImage *)iconForEntry:(NSDictionary *)dict
{
	return nil;
}

- (NSArray *)objectsForEntry:(NSDictionary *)theEntry {
    // [library loadMusicLibrary];
	// if (![library isLoaded]) return nil;

    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:1];
    [objects addObjectsFromArray:[self browseMasters]];
    
    return objects;
}

#define RdioBrowserPboardType @"com.rdio.desktop.qsbrowsercriteria"

- (NSArray *)browseMasters {
	NSArray *sortTags = [NSArray arrayWithObjects:@"Artist", @"Album", @"Track", nil]; 	
	NSMutableArray *objects = [NSMutableArray arrayWithCapacity:1];
	QSObject *newObject;
	int count = [sortTags count];
	int i;
	for (i = 0; i < count; i++) {
		NSString *rootType = [sortTags objectAtIndex:i];
		NSMutableDictionary *childCriteria = [NSMutableDictionary dictionaryWithObjectsAndKeys:rootType, @"Result", rootType, @"Type", nil];
		newObject = [QSObject objectWithName:[NSString stringWithFormat:@"Rdio Browse %@s", rootType]];
		[newObject setObject:childCriteria forType:RdioBrowserPboardType];  
		[newObject setPrimaryType:RdioBrowserPboardType];
		[objects addObject:newObject];
	}
	return objects;
}

-(void)playPause
{
    [self.rdio playpause];
}

- (void)decreaseVolume
{
    NSInteger newVolume = self.rdio.soundVolume - 10;
    if (newVolume < 0)
        newVolume = 0;
    self.rdio.soundVolume = newVolume;
}

-(void)increaseVolume
{
    NSInteger newVolume = rdio.soundVolume + 10;
    if (newVolume > 100)
        newVolume = 100;
    rdio.soundVolume = newVolume;
}

-(void)previousTrack
{
    // Previous track just goes to the begining if the current track is pase ~2 seconds, hence why
    // it is called twice sometimes.    
    if (self.rdio.playerPosition >= 3) {
        [self.rdio previousTrack];
    }

    [self.rdio previousTrack];
}

-(void)nextTrack
{
    [self.rdio nextTrack];
}

// Return a unique identifier for an object (if you haven't assigned one before)
//- (NSString *)identifierForObject:(id <QSObject>)object
//{
//	return nil;
//}

// Object Handler Methods

/*
- (void)setQuickIconForObject:(QSObject *)object
{
	[object setIcon:nil]; // An icon that is either already in memory or easy to load
}

- (BOOL)loadIconForObject:(QSObject *)object
{
	return NO;
	id data=[object objectForType:kRdioSilverType];
	[object setIcon:nil];
	return YES;
}
*/
@end

@implementation RdioControlSource

- (NSArray *) objectsForEntry:(NSDictionary *)theEntry
{
	NSMutableArray *controlObjects = [NSMutableArray arrayWithCapacity:1];
	QSCommand *command;
	NSDictionary *commandDict;
	QSAction *newObject;
	NSString *actionID;
	NSDictionary *actionDict;
	// create catalog objects using info specified in the plist (under QSCommands)
	NSArray *controls = [NSArray arrayWithObjects:@"RdioSilverPlayPauseCommand", @"RdioSilverPreviousTrackCommand", @"RdioSilverNextTrackCommand", @"RdioSilverDecreaseVolumeCommand", @"RdioSilverIncreaseVolumeCommand", nil];
    
	for (NSString *control in controls) {
		command = [QSCommand commandWithIdentifier:control];
		if (command) {
			commandDict = (NSDictionary *)[command commandDict];
			actionID = [commandDict objectForKey:@"directID"];
			actionDict = [[[commandDict objectForKey:@"directArchive"] objectForKey:@"data"] objectForKey:QSActionType];
			if (actionDict) {
				newObject = [QSAction actionWithDictionary:actionDict identifier:actionID bundle:nil];
				[controlObjects addObject:newObject];
			}
		}
	}
	return controlObjects;
}

@end