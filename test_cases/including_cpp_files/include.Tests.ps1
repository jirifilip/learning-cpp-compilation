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
}
