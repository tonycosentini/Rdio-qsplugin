//
//  RdioSilverSource.h
//  RdioSilver
//
//  Created by Tony Cosentini on 2/22/12.
//

#define RdioSilverType @"RdioSilverType"

@class RdioApplication;

@interface RdioSilverSource : QSObjectSource
{
    RdioApplication *rdio;
}

- (id)init;

-(void)playPause;
-(void)increaseVolume;
-(void)decreaseVolume;
-(void)previousTrack;
-(void)nextTrack;

@property (nonatomic, strong) RdioApplication *rdio; 

@end
