$script:here = Split-Path -Parent $MyInvocation.MyCommand.Path
$script:outPath = "$here/out"


BeforeAll {
    if (-Not (Test-Path $outPath)) {
        mkdir $outPath
    }
}


Describe "deploy" {
    It "Returns expected output" {
        g++ "$here/main.cpp" -o "$outPath/main.exe"

        $output = . "$outPath/main.exe"
        
        $output | Should -Be "Hello world"
    }
}
