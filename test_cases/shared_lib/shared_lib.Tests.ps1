Describe "Include C++ file" {
    BeforeAll {
        $here = $PSScriptRoot
        $outPath = "$here/out"

        if (Test-Path $outPath) {
            remove-item -r $outPath
        }

        mkdir $outPath

        g++ -shared "$here/src/lib.cpp" -o "$outPath/lib.dll"
        g++ -shared "$here/src/lib_alternative.cpp" -o "$outPath/lib_alternative.dll"
        g++ -w "$here/src/main.cpp" -o "$outPath/main.exe"
    }

    It "loads library dynamically" {
        $output = . "$outPath/main.exe"
        
        $output | Should -Be "1 + 2 = 3"
    }

    It "loads library 'lib.dll' when provided as an argument" {
        $output = . "$outPath/main.exe" "lib.dll"
        
        $output | Should -Be "1 + 2 = 3"
    }

    It "loads library 'lib_alternative.dll' when provided as an argument" {
        $output = . "$outPath/main.exe" "lib_alternative.dll"
        
        $output | Should -Be "1 + 2 = 4"
    }
}
