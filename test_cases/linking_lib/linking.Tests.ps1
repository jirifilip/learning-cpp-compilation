Describe "Linking C++ files" {
    BeforeAll {
        $here = $PSScriptRoot
        $outPath = "$here/out"

        if (-Not (Test-Path $outPath)) {
            mkdir $outPath
        }

        g++ -c $here/src/lib1.cpp -o $outPath/lib1.a
        g++ -c $here/src/lib2.cpp -o $outPath/lib2.a
    }

    It "Include lib1.cpp" {
        g++ -L $outPath -l:lib1.a "$here/src/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "1 + 2 = 3"
    }

    It "Include lib2.cpp" {
        g++ -L $outPath -l:lib2.a "$here/src/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "1 + 2 = 4"
    }
}
