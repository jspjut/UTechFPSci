set FPSCI_VERSION=v25.01.01
set HIDESEEK_FOLDER_ID=1hryO2ewrrQhKmApf-CizbCejUztCxEv9

@REM Get FPSci build
@REM official releases should use this path https://github.com/NVlabs/FPSci/releases/download/%FPSCI_VERSION%/FPSci.%FPSCI_VERSION%.zip
@REM unofficial releases should use this path https://github.com/jspjut/FPSci/releases/download/%FPSCI_VERSION%/FPSci.%FPSCI_VERSION%.zip
echo Downloading FPSci
curl -LO https://github.com/jspjut/FPSci/releases/download/%FPSCI_VERSION%/FPSci.%FPSCI_VERSION%.zip
echo Extracting FPSci
mkdir FPSci
tar -xf FPSci.%FPSCI_VERSION%.zip -C FPSci\
echo Removing FPSci zip
del FPSci.%FPSCI_VERSION%.zip

@REM Get hideseek model
echo Making sure gdown is installed
pip install gdown
echo Downloading HideSeek Model
mkdir model
gdown https://drive.google.com/drive/folders/%HIDESEEK_FOLDER_ID% -O model/hideseek --folder

@REM Copy configs over
echo Copying configs over
xcopy configs\*.Any FPSci\ /Y

@REM Copy model folder over
echo Copying models over
xcopy model\hideseek\* FPSci\model\hideseek\ /Y

@REM Copy scene over
echo Copying scene over
xcopy scene\*Scene.Any FPSci\scene\  /Y
