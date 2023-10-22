#!/bin/bash

MODIFIED_DIRECTORIES=$(git diff --name-only $BASE_SHA | cut -d/ -f1 | sort -u)

VALID_MODIFIED_DIRECTORIES=""

for DIR in $MODIFIED_DIRECTORIES; do
  if [ -f "$DIR/package.json" ]; then
    if [ -n "$VALID_MODIFIED_DIRECTORIES" ]; then
      VALID_MODIFIED_DIRECTORIES+=","
    fi
    VALID_MODIFIED_DIRECTORIES+="\"$DIR\""
  fi
done

if [ -n "$VALID_MODIFIED_DIRECTORIES" ]; then
  echo "{\"dirs\":[${VALID_MODIFIED_DIRECTORIES}]}"
else
  echo ""
fi
