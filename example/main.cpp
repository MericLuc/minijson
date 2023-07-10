#include <miniJSON/JSON.h>
#include <iostream>

using namespace JSON;

int main(/*int argc, char* argv[]*/) {

    auto obj{ Object::newObject() };
    auto arr{ Object::newArray(3) };

    arr.append(Object::fromStr("{'str':'str'}"));
    arr.insert(1, Object::newString("JSON"));
    arr.erase(2);

    obj.insert("Hello"  , Object::newString("world!\n"));
    obj.insert("GoodBye", Object::newInt(42));
    obj.insert("arr"    , arr);
    

    std::cout << obj.toStr() << std::endl;
    // { "Hello": "world!\n", "GoodBye": 42, "arr": [ { "str": "str" }, "JSON" ] }


    return EXIT_SUCCESS;
}