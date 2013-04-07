//
//  MockUserDefaults.m
//  CardGame
//
//  Created by Vladimir on 07.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "MockUserDefaults.h"

@implementation MockUserDefaults

- (NSMutableDictionary*) storage
{
    if (!_storage)
        _storage = [[NSMutableDictionary alloc] init];    
    return _storage;
}

- (NSDictionary*) dictionaryForKey: (id) key
{
    return [self.storage objectForKey: key];
}

- (id) objectForKey: (id) key
{
    return [self.storage objectForKey: key];
}

- (void) setObject: (id) obj forKey: (id) key
{
    [self.storage setObject: obj forKey: key];
}

- (void) synchronize
{
}

@end
