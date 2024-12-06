#include <windows.h>
#include <stdio.h>
#include <iostream>
#include <vector>


void abortWithMessage(const std::string& message) {
    std::cerr << message << std::endl;
    std::abort();
}


std::string resolveLibraryName(const std::vector<std::string>& arguments) {
    if (arguments.empty()) {
        return "lib.dll";
    }

    return arguments.at(0);
}


class LoadedLibrary {
private:
    std::string name;
    HINSTANCE library = nullptr;

    typedef int (*plusFunc)(int, int);

public:
    plusFunc plus = nullptr;

    LoadedLibrary(std::string name) : name(name) {
        library = LoadLibrary(name.data());

        if (library == NULL) {
            abortWithMessage("Unable to load library");
        }

        plus = (plusFunc) GetProcAddress(library, "plus");

        if (plus == NULL) {
            abortWithMessage("Unable to get function address");
        }
    };

    ~LoadedLibrary() {
        if (library != nullptr) {
            FreeLibrary(library);
        }
    }
};


int main(int argumentCount, char* argumentVector[]) {
    std::vector<std::string> arguments{ argumentVector + 1, argumentVector + argumentCount }; 
    std::string libraryName = resolveLibraryName(arguments);
    
    LoadedLibrary lib { libraryName };
    int result = lib.plus(1, 2);

    std::cout << "1 + 2 = " << result << std::endl;
}


