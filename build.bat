
set os_version=""
if "%1"=="win10-x64" (
    set current_dir=%cd%
    set qml_folder=.\.bin\Release\%1\qml
    set js_folder=.\.bin\Release\%1\js
    set icons_folder=.\.bin\Release\%1\icons
    
    mkdir %qml_folder% 
    mkdir %js_folder%
    mkdir %icons_folder% 
    
    dotnet publish -c Release -r %1
    xcopy /s/e %current_dir%\qml %current_dir%\%qml_folder%
    xcopy /s/e %current_dir%\js %current_dir%\%js_folder%
    xcopy /s/e %current_dir%\icons %current_dir%\%icons_folder%
)
