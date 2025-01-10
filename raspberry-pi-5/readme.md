# Initial preparation of OS on Raspberry Pi 5

Use Raspberry Pi Imager for macOS to prepare SD card

- image `Raspberry Pi OS Lite (64bit)` released `2024-11-19`
- set Customizations:
  - set hostname: `rpi5.local`
  - set username and password: `pi`
  - setup WIFI with password
  - locale to `Europe/Bratislava`
  - keyboard to US
  - enable SSH (use password auth)

Test:

```sh
ping rpi5.local

ssh pi@rpi5.local
```

Notes:

```sh
id pi

# uid=1000(pi) gid=1000(pi) groups=1000(pi),4(adm),20(dialout),24(cdrom),27(sudo),29(audio),44(video),46(plugdev),60(games),100(users),102(input),105(render),110(netdev),995(spi),994(i2c),993(gpio),115(lpadmin)
```

## Install Raspberry Pi M.2 HAT+ with SSD

see https://www.raspberrypi.com/documentation/accessories/m2-hat-plus.html#m2-hat-plus-installation

```sh
ssh pi@rpi5.local

# then manually on rpi:

sudo apt update && sudo apt full-upgrade

sudo reboot now

# after reboot check bootloader. If current, shutdown rpi and install HAT.
```

After HAT with SSD disk was connecter to the rpi board, run rpi again and set boot order:

```sh
sudo raspi-config

# Under `Advanced Options > Boot Order`, choose `NVMe/USB boot`. Then, exit `raspi-config` with `Finish`
# Do NOT reboot just yet.
```

Use `rpi-clone` to clone SD card to NVMe drive.

```sh
curl https://raw.githubusercontent.com/geerlingguy/rpi-clone/master/install | sudo bash

sudo rpi-clone nvme0n1

# set "neviem" as disk label
```

Shutdown rpi, remove SD card and boot. Rpi should start from NVMe drive now.

Notes:

```sh
id pi

# uid=1000(pi) gid=1000(pi) groups=1000(pi),4(adm),20(dialout),24(cdrom),27(sudo),29(audio),44(video),46(plugdev),60(games),100(users),102(input),105(render),110(netdev),995(spi),994(i2c),993(gpio),115(lpadmin)

id

# uid=1000(pi) gid=1000(pi) groups=1000(pi),4(adm),20(dialout),24(cdrom),27(sudo),29(audio),44(video),46(plugdev),60(games),100(users),102(input),105(render),110(netdev),115(lpadmin),993(gpio),994(i2c),995(spi)

sudo id

# uid=0(root) gid=0(root) groups=0(root)

```

# Ansible automation

As I don't want to mess with installing Python and Ansible itself, I decided to run Ansible from a Docker.

To build my Ansible image:

```sh
myansible/build.sh
```

To run it:

Create `config.yaml` file, use `config.example.yaml` as example.

```sh
./run.sh
```
