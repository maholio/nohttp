Hi there 👋 

This script will enable/disable port 80 on your router.

### How to use it?
Run this commands on your host machine (NOT router):
```
nano port_config.sh
```
Paste code from above (or use v1 if you want) and save file.

```
scp -O -r port_config.sh root@192.168.8.1:/tmp
```
Enter password

```
ssh root@192.168.8.1
```

Enter password again

```
cd /tmp
```
```
./port_config.sh
```


### DOUBLE CHECK THAT HTTPS SUPPORTED BEFORE RUNNING THE SCRIPT
Just replace `http://` to `https://` in link. If Admin page works, you can run the script. If not, use its option to enable http again.

## 🇺🇦 Author stands with Ukraine 🇺🇦
If you want to thank me, please [donate to Ukrainian army](https://war.ukraine.ua)
