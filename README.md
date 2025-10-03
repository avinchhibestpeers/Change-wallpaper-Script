# Change-wallpaper-Script
Change Wallpaper after certain period of time in ubuntu.

**Note** 
- This only works for Gnome-desktop with Ubuntu.
- Use script `chg_wallpaper_v1.sh` if ubuntu version greater than 22 other. For lower ubuntu version than 22 use `chg_wallpaper_v2.sh`.
- Supports file extension: JPG, JPEG and PNG
  
## How to Setup

### 1. Add directory path in script
- Find `img_dir_path` variable in script. Add *absolute* path of directory containing  wallpapers.

### 2. Setup Cron job
- Run following command this will open code editor. If ask for choosing code editor choose `nano`.
```
crontab -e
```
Add any one of following code to change wallpaper on regular interval.
**For 1 min interval**
```
* * * * * /absolute/path/to/chg_wallpaper_script_v1.sh >> absolute/path/to/cron_logs.log 2>&1
```
**For n min interval**
```
*/n * * * * /absolute/path/to/chg_wallpaper_script_v1.sh >> absolute/path/to/cron_logs.log 2>&1
```

PS: You can View logs in `cron_log.log`, if something went wrong.



