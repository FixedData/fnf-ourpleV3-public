#!/bin/sh

# For patching discord_rpc and hxCodec to work properly on Linux.
# Please only run this after you have done "hmm install"
# Make sure you have dos2unix installed, I'm using it because when I tried to apply patch
# the patch command got annoyed by differing line endings
#
# The patch for discord_rpc is to fix an issue with the rapidjson library that makes it refuse to compile
# The patch for hxCodec is to fix a crash that happens apon loading a video due to some kind of lua clash (?)
# Apologies, I'm not too versed in VLC, I just know nuking VLCs lua capabilities fixes the crash. 
# I also have to correct a broken symlink that prevents vlc from being linked properly, hence the symlink commands.

dos2unix .haxelib/discord_rpc/git/lib/rapidjson/include/rapidjson/document.h
dos2unix .haxelib/hxCodec/2,6,1/hxcodec/vlc/VLCBitmap.hx # Annoying
patch .haxelib/discord_rpc/git/lib/rapidjson/include/rapidjson/document.h < ./patch4linux/document.h.patch
patch .haxelib/hxCodec/2,6,1/hxcodec/vlc/VLCBitmap.hx < ./patch4linux/VLCBitmap.hx.patch
ln -sf ./libvlc.so.5.6.0 .haxelib/hxCodec/2,6,1/lib/vlc/lib/Linux/libvlc.so.5
ln -sf ./libvlccore.so.9.0.0 .haxelib/hxCodec/2,6,1/lib/vlc/lib/Linux/libvlccore.so.9

echo Game should workie now!!!!!!! Try "Lime test Linux"