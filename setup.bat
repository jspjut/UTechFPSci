set FPSCI_VERSION=v23.04.01
set HIDESEEK_FOLDER_ID=1hryO2ewrrQhKmApf-CizbCejUztCxEv9

@REM Get FPSci build
echo Downloading FPSci
curl -LO https://github.com/NVlabs/FPSci/releases/download/%FPSCI_VERSION%/FPSci.%FPSCI_VERSION%.zip
echo Extracting FPSci
mkdir FPSci
tar -xf FPSci.%FPSCI_VERSION%.zip -C FPSci\
echo Removing FPSci zip
del FPSci.%FPSCI_VERSION%.zip

@REM Get hideseek model
echo Making sure gdown is installed
pip install gdown
echo Downloading HideSeek Model
gdown https://drive.google.com/%HIDESEEK_FOLDER_ID% -O model/hideseek --folder

@REM Copy configs over
echo Copying configs over
xcopy configs\*.Any FPSci\ /Y

@REM Copy model over
echo Copying models over
xcopy model\* FPSci\models\ /Y

@REM Copy scene over
echo Copying scenes over
xcopy scenes\*Scene.Any FPSci\scenes\  /Y