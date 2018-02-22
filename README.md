# sum-videos-time.sh

## How to use it
1. Install libav-tools: 
```
sudo apt-get install libav-tools
```
2. Download the file [`sum-videos-time.sh`](./sum-videos-time.sh)
3. Make the file executable: 
```
chmod u+x sum-videos-time.sh
```
4. Run the file, with 1 or 2 arguments:
```
./sum-videos-time.sh /directory-full-path -R
```
* If you use `-r` or `-R`, it will search for files recursively (inside all the folders of `directory-full-path`). 
* It's important to mention that *you have to pass the directory full path*. If you want to search in the current directory, so you can use `.` instead, like this:
```
./sum-videos-time.sh . -R
```
5. When you run the file, it will output something like this:

![output](https://user-images.githubusercontent.com/12154623/36568086-7901638c-1807-11e8-8d33-db4ffe0eac41.jpg)

## Supported files
This script only supports `.mp4`,`.mkv`,`.avi` and `.flv` files. If you want to include more types, just update the script file.

