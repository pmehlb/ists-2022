# Author: Patrick Mehlbaum (@pmehlb)
# Installs and starts SysMon with a specified XML config.

# constants (for data sources)
$URL_SYSMON_CFG = "https://raw.githubusercontent.com/pmehlb/ists-2021/main/data/SysMonConfig.xml";
$URL_SYSMON_ZIP = "https://github.com/pmehlb/ists-2021/raw/main/data/Sysmon.zip";
$zip_file = "sysmon.zip";
$cfg_file = "sysmon.xml";
$TEMP_DIR = $env:TEMP;

# make a temporary folder, and cd into it
New-Item -Path "$($TEMP_DIR)\SysMon" -ItemType Directory -Force; # make a new directory in the temp folder
Set-Location "$($TEMP_DIR)\SysMon"; # cd into that directory

# download SysMon zip and extract it
Invoke-WebRequest -Uri $URL_SYSMON_ZIP -OutFile $zip_file;
Expand-Archive -Path $zip_file -Force; # extract the zip

# download SysMon config
Invoke-WebRequest -Uri $URL_SYSMON_CFG -OutFile $cfg_file;

# install SysMon with our config
# needs to run as admin
Start-Process -FilePath "sysmon\sysmon64.exe" -ArgumentList "-accepteula", "-i sysmon.xml" -Verb RunAs;