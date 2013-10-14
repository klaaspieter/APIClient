#import "SpecHelper.h"

#import "APIJSONSerializer.h"

SpecBegin(APIJSONSerializer)

describe(@"APIJSONSerializer", ^{
    it(@"deserializes JSON", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        expect([serializer deserializeJSON:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]]).to.equal(@{});
    });

    it(@"raises if the JSON could not be parsed", ^{
        APIJSONSerializer *serializer = [[APIJSONSerializer alloc] init];
        expect(^{
            [serializer deserializeJSON:[@"\"string\"" dataUsingEncoding:NSUTF8StringEncoding]];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SpecEnd
