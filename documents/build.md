# Build
This document shows some ways to configure `build.bat` files for different languages and applications.

## Cmake
Use `MSVC` in combination with `Qt` and `Ninja` to compile a `Cmake` project and run the generated executable.

```bat
    set QT_DIR=<path-to-qt-version>\msvc2019_64
    set PROJECT_DIRECTORY=<path-to-project-location>

    cd %PROJECT_DIRECTORY%
    call "<path-to-visual-studio-version>\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64
    cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Release -S . -B build\release -G Ninja
    cmake --build build\release --config Release --target all --

    copy build\release\compile_commands.json compile_commands.json
    start build\release\main.exe
```

## Latex
Generate pdf output using `latexmk` and display it with `SumatraPDF`.

```bat
    cd <path-to-file>
    latexmk -pdf file.tex
    start SumatraPDF -reuse-instance file.pdf
```

## Vhdl
Compile a top level file and start the simulator both using the `Xilinx-Vivado` toolchain.
More information can be found under [Xilinx-Vivado](https://docs.xilinx.com/r/2022.1-English/ug900-vivado-logic-simulation/Simulating-in-Batch-or-Scripted-Mode-in-Vivado-Simulator).

```bat
    set top=work.file_tb

    if not exist xsim mkdir xsim
    cd xsim

    call "<path-to-vivado-version>\bin\xvhdl.bat" -work work "<path-to-file>\file.vhd" "<path-to-file>\file_tb.vhd" -nolog
    if %ERRORLEVEL% gtr 0 exit

    call "<path-to-vivado-version>\bin\xelab.bat" -top %top% -debug wave -nolog
    if %ERRORLEVEL% gtr 0 exit

    start "" /b "<path-to-vivado-version>\bin\xsim.bat" %top% -gui -nolog
```

Alternatively a project file `project.prj` can be used to include all necessary subfiles. Nevertheless, the project's top file must still be specified separately.


```bat
    set top=work.file_tb

    if not exist xsim mkdir xsim
    cd xsim

    call "<path-to-vivado-version>\bin\xvhdl.bat" -prj <path-to-file>\project.prj -nolog
    if %ERRORLEVEL% gtr 0 exit

    call "<path-to-vivado-version>\bin\xelab.bat" -top %top% -debug wave -nolog
    if %ERRORLEVEL% gtr 0 exit

    start "" /b "<path-to-vivado-version>\bin\xsim.bat" %top% -gui -nolog
```

A simple `project.prj` might look like the following example. More information can be found under [Xilinx-Vivado](https://docs.xilinx.com/r/2022.1-English/ug900-vivado-logic-simulation/Project-File-.prj-Syntax).

```
    # Compile vhdl design source files
    vhdl work \
    "file.vhd" \
    "file_tb.vhd" \

    # Do not sort compile order
    nosort
```
