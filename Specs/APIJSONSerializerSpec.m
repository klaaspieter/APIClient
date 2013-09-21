#import "SpecHelper.h"

#import "APIJSONSerializer.h"

SpecBegin(APIJSONSerializer)

describe(@"APIJSONSerializer", ^{
    it(@"deserializes JSON", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        expect([serializer deserializeJSON:@"{}"]).to.equal(@{});
    });
});

SpecEnd
