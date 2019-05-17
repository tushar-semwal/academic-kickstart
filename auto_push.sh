hugo
git add .
git commit -m "update"
git push origin HEAD:master --force
#git push -u origin master

cd public
git add .
git commit -m "build"
git push origin HEAD:master --force
#git push origin master
cd ..
