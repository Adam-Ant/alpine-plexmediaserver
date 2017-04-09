#!/bin/sh -e
if [ -f /config/Plex\ Media\ Server/plexmediaserver.pid ] 
then 
  echo "Removing old PID file"
  rm /config/Plex\ Media\ Server/plexmediaserver.pid 
fi

# This codec folder seems to be populated dynamically - so we need to check for any more binaries to patch on every boot :(
if [ -d /config/Plex\ Media\ Server/Codecs ]
then
  echo "Patching codecs..."
  find /config/Plex\ Media\ Server/Codecs -type f -perm /0111 -exec sh -c "file --brief \"{}\" | grep -q "ELF" && patchelf --set-interpreter \"$GLIBC_LD_LINUX_SO\" \"{}\" " \;
  echo "Done!"
fi

/glibc/start_pms
