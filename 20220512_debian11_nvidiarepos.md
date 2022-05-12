FIX: Error NO_PUBKEY A4B469963BF863CC on Debian 11
--------------------------------------------------

Error on NVIDIA driver repository for debian 11

```
apt update
Hit:1 http://deb.debian.org/debian bullseye InRelease
Get:2 http://security.debian.org/debian-security bullseye-security InRelease [44.1 kB]
Get:3 http://ftp.debian.org/debian bullseye-backports InRelease [44.2 kB]
Get:4 http://deb.debian.org/debian bullseye-updates InRelease [39.4 kB]
Get:5 https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  InRelease [1581 B]
Get:6 http://ftp.debian.org/debian bullseye-backports/main amd64 Packages.diff/Index [63.3 kB]
Get:7 http://ftp.debian.org/debian bullseye-backports/main Translation-en.diff/Index [63.3 kB]
Get:8 http://security.debian.org/debian-security bullseye-security/main amd64 Packages [146 kB]
Err:5 https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY A4B469963BF863CC
Get:9 http://ftp.debian.org/debian bullseye-backports/main amd64 Packages T-2022-05-11-0202.22-F-2022-05-08-0206.12.pdiff [42.9 kB]
Get:10 http://security.debian.org/debian-security bullseye-security/main Translation-en [90.1 kB]
Get:9 http://ftp.debian.org/debian bullseye-backports/main amd64 Packages T-2022-05-11-0202.22-F-2022-05-08-0206.12.pdiff [42.9 kB]
Get:11 http://ftp.debian.org/debian bullseye-backports/main Translation-en T-2022-05-10-2005.15-F-2022-05-08-0206.12.pdiff [23.8 kB]
Get:11 http://ftp.debian.org/debian bullseye-backports/main Translation-en T-2022-05-10-2005.15-F-2022-05-08-0206.12.pdiff [23.8 kB]
Reading package lists... Done
W: GPG error: https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY A4B469963BF863CC
E: The repository 'https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  InRelease' is no longer signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

To fix this run the following line and add the GPG key

```
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
Executing: /tmp/apt-key-gpghome.wbP6V7mNcw/gpg.1.sh --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub
gpg: requesting key from 'https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub'
gpg: key A4B469963BF863CC: public key "cudatools <cudatools@nvidia.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```


Check if the fix works
```
apt update
Hit:1 http://deb.debian.org/debian bullseye InRelease
Hit:2 http://security.debian.org/debian-security bullseye-security InRelease
Hit:3 http://ftp.debian.org/debian bullseye-backports InRelease
Hit:4 http://deb.debian.org/debian bullseye-updates InRelease
Get:5 https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  InRelease [1581 B]
Get:6 https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64  Packages [165 kB]
```


