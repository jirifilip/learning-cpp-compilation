#include <windows.h>
#include <stdio.h>
#include <iostream>


typedef int (*plusFunc)(int, int);


void abortWithMessage(const std::string& message) {
    std::cerr << message << std::endl;
    std::abort();
}


int main() {
    HINSTANCE library = LoadLibrary(TEXT("lib.dll"));

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


