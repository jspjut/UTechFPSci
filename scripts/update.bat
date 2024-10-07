@REM set HIDESEEK_FOLDER_ID=1hryO2ewrrQhKmApf-CizbCejUztCxEv9

@REM @REM Get hideseek model
@REM echo Making sure gdown is installed
@REM pip install gdown
@REM echo Downloading HideSeek Model
@REM mkdir model
@REM gdown https://drive.google.com/drive/folders/%HIDESEEK_FOLDER_ID% -O model/hideseek --folder

@REM @REM Copy model folder over
@REM echo Copying models over
@REM xcopy model\hideseek\* FPSci\model\hideseek\ /Y

@REM Copy configs over
echo Copying configs over
xcopy configs\*.Any FPSci\ /Y

@REM Copy scene over
echo Copying scene over
xcopy scene\*Scene.Any FPSci\scene\  /Y
