# DAB Container Template Oluşturma
Proxmox ile kendi LXC container template’lerini oluşturup daha sonra container’ları hızlıca bu template’lerden oluşturabilirsin. Bunun için DAB (Debian Appliance Builder) kullanılıyor. Temel olarak iki dosya yeterli. Boş örnekler için https://git.proxmox.com/?p=dab-pve-appliances.git;a=tree adresine bak.

* Makefile
* dab.conf

## Proxmox Sanal Makinesi Yoksa
Proxmox içinde bir sanal makinede Proxmox kurulu değilse sanal makineye Proxmox kur:

1. Proxmox içerisinde sanal makina (KVM) içine Proxmox kur (Asıl proxmox kurulumunu kirletmemek için)
2. Enterprise repoyu durdur ve community repo’ları ekle (https://pve.proxmox.com/wiki/Package_Repositories)
    1. `pico /etc/apt/sources.list.d/pve-enterprise.list`
(Başına # koyarak kaldır.)
    2. `pico /etc/apt/sources.list`

```
            # PVE pve-no-subscription repository provided by proxmox.com,
            # NOT recommended for production use
            deb http://download.proxmox.com/debian/pve stretch pve-no-subscription
```
        
3. DAB kur: `apt-get install dab`
4. git kur: `apt-get install git-core`

## Template Oluşturma
1. Sistemi son versiyona güncelle:
    1. `apt-get update`
    2. `apt-get dist-upgrade`
2. Fortibase template’lerini indir: `git clone https://github.com/fortibase/proxmox-dab-templates.git`
3. Yeni template oluşturmak için dizinin içine girip istediğin klasörü oluştur. Kendi _OS_ ismini kullan
    1. `mkdir proxmox-dab-templates/ubuntu-18.04-base`
    2. `cd proxmox-dab-templates/ubuntu-18.04-base`
4. Gerekli iki dosyayı oluştur. Boş dosya örnekleri için https://git.proxmox.com/?p=dab-pve-appliances.git;a=tree adresine bak.
    1. **dab.conf**
    2. **Makefile**
5. Template’i oluştur: `make`
6. Template’i kopyalamak için NAS’ı mount et: `mount 77.92.129.116:/volume1/Proxmox-Templates /mnt`
7. Oluşturulan template dosyasını NAS’a kopyala: `mv [Oluşan OS dosyası].tar.gz /mnt/template/cache`

**_Bilgi_**

* DAB’ın son sürümünün kurulumu için Proxmox repo gerekiyor. Eklemek ve diğer detaylar ile uğraşmamak için Proxmox dağıtımı kurmayı öneriyorum.
* Prosesin özeti: `make` komutu ile **_Makefile_** dosyası işletiliyor. Bu dosya `dab` komutunu kullanarak **_dab.conf_** içerisindeki belirtilen baz alınacak işletim sistemi template'ini
Proxmox firmasının suncusundan  indirip yine `dab` komutu ile gerekli değişiklikleri yapıp paketleyerek yeni bir template oluşturuyor.

**_Kaynaklar_**

1. DAB: https://pve.proxmox.com/wiki/Debian_Appliance_Builder#DAB_for_LXC_in_PVE_4.2B
2. Official empty templates: https://git.proxmox.com/?p=dab-pve-appliances.git;a=tree
3. Örnek DAB Template’ler: https://github.com/ngardiner/dab_templates

## Örnek dosyalar (Ubuntu 18.04 için)

* **Makefile**

```make
# NOTE: Makefile uses TAB for delimiter, DO NOT use SPACE to indent.
BASEDIR:=$(shell dab basedir)

all: info/init_ok
    dab bootstrap

    # YOUR CUSTOMIZATINS HERE.
    # ../scripts/base.sh
    # sed -i …

    dab finalize

info/init_ok: dab.conf
    dab init
    touch $@

.PHONY: clean
clean:
    dab clean
    rm -f *~

.PHONY: dist-clean
dist-clean:
    dab dist-clean
    rm -f *~
```

* **dab.conf**

```conf
Suite: bionic
CacheDir: ../cache
#Source: http://archive.ubuntu.com/ubuntu SUITE main restricted universe multiverse
#Source: http://archive.ubuntu.com/ubuntu SUITE-updates main restricted universe multiverse
#Source: http://archive.ubuntu.com/ubuntu SUITE-security main restricted universe multiverse
Architecture: amd64
Name: ubuntu-18.04-base
Version: 18.04-1
Section: system
Maintainer: Fortibase <admin@fortibase.com>
Infopage: http://www.fortibase.com
Description: Ubuntu Bionic (base)
 A small Ubuntu system including all standard packages customized for Fortibase.
  * Unattended upgrades and reboot enabled
  * root SSH disabled
  * SSH only via public key
  * Firewall and fail2ban enabled (HTTP, HTTPS, SSH)
  * admin user added (Non root user, which can sudo)
  * Timezone set to Istanbul
  * Locales added: tr_TR.utf8,  tr_TR,  en_US.utf8
```
