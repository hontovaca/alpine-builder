#!/bin/sh
(umask 077; cat > ~/.ssh/id_ed25519) <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
$private_key
-----END OPENSSH PRIVATE KEY-----
EOF
git config user.name none
git config user.email none
git remote set-url origin "`git config --get remote.origin.url | sed 's,https://\([^/]*\)/,git@\1:,'`"

for b in latest; do
  git subtree split -P scratch -b "rootfs-$b" $TRAVIS_COMMIT
  git checkout "rootfs-$b"
  docker run --rm vaca/builder -m http://alpine.gliderlabs.com/alpine -es > rootfs.tar.gz
  git add .
  git commit -C $TRAVIS_COMMIT
  git push -f origin "rootfs-$b"
done
