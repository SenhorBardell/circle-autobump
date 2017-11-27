#!/bin/bash -xe

# allows to rebuild existing circle build without clashing into tag conflict
# it will overwrite existing tag if it finds one

BUMP_OUT=$(bumpversion patch --dry-run --list)
GIT_OUT=$(git describe --tags --abbrev=0)
NEW_VERSION=${BUMP_OUT:120}
OLD_VERSION=${GIT_OUT:1}
if [ ${NEW_VERSION} == ${OLD_VERSION} ]; then
    git tag -d v${OLD_VERSION}
    git reset --hard HEAD~1
fi
bumpversion patch --tag --commit