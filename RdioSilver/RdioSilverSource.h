//
//  RdioSilverSource.h
//  RdioSilver
//
//  Created by Tony Cosentini on 2/22/12.
//

#define RdioSilverType @"RdioSilverType"

@class RdioApplication;
@class RdioDatabase;

@interface RdioSilverSource : QSObjectSource
{
    RdioApplication *rdio;
    RdioDatabase *collection;
}

- (id)init;

-(void)playPause;
-(void)increaseVolume;
-(void)decreaseVolume;
-(void)previousTrack;
-(void)nextTrack;

-(NSArray *)browseMasters;

@property (nonatomic, strong) RdioApplication *rdio; 
@property (nonatomic, strong) RdioDatabase *collection;

@end

@interface RdioControlSource : QSObjectSource {
    
}
@end
