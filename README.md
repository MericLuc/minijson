# miniJSON

**:star2: A lightweight C++ wrapper around libjson-c :star2:**

Just an easy-to-use C++ JSON library.

It wraps [libjson-c](https://github.com/json-c/json-c) and is therefore easily extendable to fit your needs.

## How to use

- `CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.11)

project(miniJSON_example)

set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(miniJSON REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} miniJSON)
```

- `main.cpp`

```c++
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
```


## How to install

- Install

```bash
cmake [-S ${path/to/src}] [-DCMAKE_NSTALL_PREFIX=${install/prefix}] .
make
make install
```

- Uninstall

```bash
make uninstall
```

- Configuration options

| name                 | type     | description                        | default value
| -------------------- | -------- | ---------------------------------- | ---------------
|  `BUILD_SHARED_LIBS` | boolean  | Build miniJSON as a shared library | ON
|  `BUILD_EXAMPLE`     | boolean  | Also build provided usage example  | OFF


## Dependencies

miniJSON depends on :
- [libjson-c](https://github.com/json-c/json-c)
