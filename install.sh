sed -i 's/ubuntu-server/dc1 dc1.nkitp21.lab/' /etc/hosts
apt update
apt install -y samba smbclient winbind libpam-winbind libnss-winbind krb5-kdc libpam-krb5 
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak 
mv /etc/krb5.conf /etc/krb5.conf.bak
samba-tool domain provision --use-rfc2307 --interactive
cp /var/lib/samba/private/krb5.conf /etc 
systemctl mask smbd nmbd winbind 
systemctl disable --now smbd nmbd winbind 
systemctl unmask samba-ad-dc 
systemctl enable  --now samba-ad-dc 
systemctl disable --now systemd-resolved 
unlink /etc/resolv.conf 
echo "nameserver 127.0.0.1
search nkitp21.lab" > /etc/resolv.conf
samba-tool domain passwordsettings set --complexity=off --history-length=0 --min-pwd-age=0 --max-pwd-age=0 --min-pwd-length=3
echo "---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
The Installation Of UBUNTU CONTROLLER Is Complete
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------"
