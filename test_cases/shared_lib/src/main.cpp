#include <windows.h>
#include <stdio.h>
#include <iostream>
#include <vector>


typedef int (*plusFunc)(int, int);


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


int main(int argumentCount, char* argumentVector[]) {
    std::vector<std::string> arguments{ argumentVector + 1, argumentVector + argumentCount }; 
    std::string libraryName = resolveLibraryName(arguments);
    
    HINSTANCE library = LoadLibrary(libraryName.data());

    if (library == NULL) {
        abortWithMessage("Unable to load library");
    }

    plusFunc plus = (plusFunc) GetProcAddress(library, "plus");

    if (plus == NULL) {
        abortWithMessage("Unable to get function address");
        FreeLibrary(library);
    }

    int result = (plus)(1, 2);

    std::cout << "1 + 2 = " << result << std::endl;
    
    FreeLibrary(library);
}


