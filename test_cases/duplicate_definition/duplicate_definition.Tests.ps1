Describe "Include C++ file" {
    BeforeAll {
        $here = $PSScriptRoot
        $outPath = "$here/out"

        if (Test-Path $outPath) {
            remove-item $outPath
        }

        mkdir $outPath
    }

    It "Included twice" {
        g++ -w "$here/src/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "included twice"
    }

    It "Included once" {
        g++ -w "$here/src/main_included_once.cpp" -o "$outPath/main_included_once.exe"

        $output = . "$outPath/main_included_once.exe"
        
        $output | Should -Be "included once"
    }
}
