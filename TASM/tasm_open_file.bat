:loop 
@set /p _lab="Name: " 
@"C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe" -c "@mount F C:\Users\Redmi\Documents\ComputingSystemsArchitecture\TASM" -c "@F:" -c "@tasm /zi %_lab%.asm" -c "@tlink /v %_lab%.obj" -c "@paUSE" -c "@td %_lab%.exe" 
@goto pause