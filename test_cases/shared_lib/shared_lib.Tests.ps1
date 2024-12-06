Describe "Include C++ file" {
    BeforeAll {
        $here = $PSScriptRoot
        $outPath = "$here/out"

        if (Test-Path $outPath) {
            remove-item -r $outPath
        }

        mkdir $outPath
    }

    It "loads library dynamically" {
        g++ -shared "$here/src/lib.cpp" -o "$outPath/lib.dll"

        g++ -w "$here/src/main.cpp" -o "$outPath/main.exe"
        $output = . "$outPath/main.exe"
        
        $output | Should -Be "1 + 2 = 3"
    }
}
