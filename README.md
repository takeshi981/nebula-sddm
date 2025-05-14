
## Theme for Sddm-qt6 (Plasma 6)


## How to install:

Clone this repository
```sh
sudo git clone https://github.com/takeshi981/nebula-sddm.git /usr/share/sddm/themes/nebula
```
Edit /etc/sddm.conf
```sh
[Theme]
Current=nebula
```
Edit /etc/sddm.conf.d/virtualkbd.conf
```sh
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf
```
