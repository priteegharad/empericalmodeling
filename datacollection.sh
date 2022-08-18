#! /bin/bash



for cpu in 1 2 3 4
do
for mem in "100m" "500m" "1000m" "2000m"
do
for dwbps in "/dev/sda:10mb" "/dev/sda:50mb" "/dev/sda:100mb" "/dev/sda:150mb"
do
for drbps in "/dev/sda:10mb" "/dev/sda:50mb" "/dev/sda:100mb" "/dev/sda:150mb"
do
docker run --cpus=$cpu --memory=$mem --device-write-bps $dwbps --device-read-bps $drbps --privileged -v /var/www:/home/ --name last1 -dit krshailesh/filebench_cs681
for numoffile in 100 300 500 1000
do
for meanwidths in 10 30 50 100
do
for numofthreads in 1 2 4
do
for iosize in "3m" "5m" "10m"
do
# overwrite webserver.f file and change the file
echo "






define fileset name=bigfileset,path="\tmp",size=100,entries=$numoffile,dirwidth=$meanwidths,prealloc=100,readonly
define fileset name=logfiles,path="\tmp",size=100,entries=1,dirwidth=$meanwidths,prealloc



define process name=filereader,instances=1
{
thread name=filereaderthread,memsize=10m,instances=$numofthreads
{
flowop openfile name=openfile1,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile1,fd=1,iosize=$iosize
flowop closefile name=closefile1,fd=1
flowop openfile name=openfile2,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile2,fd=1,iosize=$iosize
flowop closefile name=closefile2,fd=1
flowop openfile name=openfile3,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile3,fd=1,iosize=$iosize
flowop closefile name=closefile3,fd=1
flowop openfile name=openfile4,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile4,fd=1,iosize=$iosize
flowop closefile name=closefile4,fd=1
flowop openfile name=openfile5,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile5,fd=1,iosize=$iosize
flowop closefile name=closefile5,fd=1
flowop openfile name=openfile6,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile6,fd=1,iosize=$iosize
flowop closefile name=closefile6,fd=1
flowop openfile name=openfile7,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile7,fd=1,iosize=$iosize
flowop closefile name=closefile7,fd=1
flowop openfile name=openfile8,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile8,fd=1,iosize=$iosize
flowop closefile name=closefile8,fd=1
flowop openfile name=openfile9,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile9,fd=1,iosize=$iosize
flowop closefile name=closefile9,fd=1
flowop openfile name=openfile10,filesetname=bigfileset,fd=1
flowop readwholefile name=readfile10,fd=1,iosize=$iosize
flowop closefile name=closefile10,fd=1
flowop appendfilerand name=appendlog,filesetname=logfiles,iosize=16k,fd=2
}
}




run 20
"> webserver.f




docker exec -it last1 filebench -f /home/webserver.f >> result.txt
done
done
done
done
docker stop last1
docker rm last1



done
done
done
done