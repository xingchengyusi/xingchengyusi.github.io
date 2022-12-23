#!/bin/bash

# hexo deploy
hexo g
hexo clean
hexo deploy
echo "success deploy"

# github backup
git remote add origin git@github.com:xingchengyusi/xingchengyusi.github.io.git
git add .
git commit -m "hexo backup"
git push origin backup
echo "success backup"
