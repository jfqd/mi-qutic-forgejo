# Paste default environment file
echo "PATH=/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin" > \
  /home/forgejo/.ssh/environment
chown forgejo:forgejo /home/forgejo/.ssh/environment

# Enable environment configuration for users
gsed -i \
  -e 's:.*PermitUserEnvironment.*no:PermitUserEnvironment yes:g' \
  /etc/ssh/sshd_config

svcadm restart svc:/network/ssh:default

# if mdata-get vfstab 1>/dev/null 2>&1; then
#   MOUNT_FOLDER=$(mdata-get vfstab | awk '{print $3}')
#   if [[ -f "${MOUNT_FOLDER}/app.ini" ]]; then
#     mkdir -p /home/forgejo/forgejo/conf/
#     cp "${MOUNT_FOLDER}/app.ini" /home/forgejo/forgejo/conf/app.ini
#   else
#     # TODO: setup app.ini via mdata if custom conf is missing
#   fi
# fi

svccfg import /opt/local/lib/svc/manifest/forgejo.xml
svcadm enable -r svc:/application/forgejo:default

ln -nfs /var/svc/log/application-forgejo:default.log /var/log/gitea_log