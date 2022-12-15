if mdata-get vfstab 1>/dev/null 2>&1; then
  # ensure we cannot write into the
  # folder before mounting it!
  MOUNT_FOLDER=$(mdata-get vfstab | awk '{print $3}')
  mkdir -p "${MOUNT_FOLDER}"
  chmod 0550 "${MOUNT_FOLDER}"
fi