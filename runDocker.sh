docker build --tag 'rhd2000' .
docker create --name extract rhd2000
docker cp extract:/source/RHD2000interface-x86_64.AppImage RHD2000interface-x86_64.AppImage
docker rm extract