#!/bin/bash

folderBuild="dist"
folderDeploy="docs"

echo "Building started..."
npm run build

rm -r $folderDeploy
mv $folderBuild $folderDeploy
