Describe "Include C++ file" {
    BeforeAll {
        $here = $PSScriptRoot
        $outPath = "$here/out"

        if (-Not (Test-Path $outPath)) {
            mkdir $outPath
        }
    }

    It "Returns expected output" {
        write-host $outPath
        g++ "$here/src/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "1 + 2 = 3"
    }

    It "Works with IncludePath" {
        write-host $outPath
        g++ -I $here/src/folder/subfolder  "$here/src/main_include_path.cpp" -o "$outPath/main_include_path.exe"

        $output = . "$outPath/main_include_path.exe"
        
        $output | Should -Be "int = 5"
    }
}
