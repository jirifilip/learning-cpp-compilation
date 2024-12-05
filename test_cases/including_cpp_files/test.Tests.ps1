$script:here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "deploy" {
    It "Returns expected output" {
        $outPath = "$here/out"

        if (-Not (Test-Path $outPath)) {
            mkdir $outPath
        }

        g++ "$here/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "Hello world"
    }
}
