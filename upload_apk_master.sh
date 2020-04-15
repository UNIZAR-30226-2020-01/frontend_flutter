#!/bin/bash

# Script para subir la apk a la rama master
apkfile='app-release.apk'

cp "spotiseven/build/app/outputs/apk/release/$apkfile" $HOME

# Configuramos Git
git config --global user.email "pedro.tamargo.allue@gmail.com"
git config --global user.name "Pedro Tamargo"

# Clonamos el repositorio
cd $HOME
git clone --quiet --branch master https://piter1902:$GITHUB_API_KEY@github.com/UNIZAR-30226-2020-01/frontend_flutter.git

# Nos introducimos al repositorio y copiamos la apk
cd frontend_flutter
cp $HOME/$apkfile

git add .
git remote add origin https://piter1902:$GITHUB_API_KEY@github.com/UNIZAR-30226-2020-01/frontend_flutter.git
git add .
git commit -m 'TravisCI generated apk: [skip ci]'
git push origin master -fq

# Mensaje de finalización
echo -e 'Listo! \n'
