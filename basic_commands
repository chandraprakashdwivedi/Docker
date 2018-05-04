First listing and downloading images

1. docker images list                  #This will list the image id

To search for images
#docker image search image[image:tag]
For eg.
#docker image search centos:centos7

Images are downloaded in location 

/var/lib/docker/devicemapper/devicemapper/data stores the images

directory vary depending on the driver Docker is using for storage. 
You can manually set the storage driver with the -s or --storage-driver= option to the Docker daemon. 

2. Basic command to run container 

#docker run -it --name centos7 3afd47092a0e

3afd47092a0e ->this is the image id

Note: To exit from container without terminating use  (ctrl+p+q  )

3. To login again in container

#docker attach (container_id)        Note:first 3 character are enough


4.To see default docker network 

#docker network ls

To see details of particular network type and to know the ip's of container

#docker network inspect bridge

Note: Linux command to check bridges
#brctl show

5. To kill docker processes

#docker rm -v $(docker ps --filter status=created -q)

#docker stop $(docker ps -a -q)

#docker rm $(docker ps -a -q)

6. To execute commands directly inside docker container 

#docker exec -it centos7 bash

7. Docker Network:

#docker network create --subnet=192.168.1.0/16 --gateway=192.168.1.1  mynet


8. Running Docker with specific cpu,cpu-core, ram ,network,volume,port,memory

#docker run --net mynet --ip 192.168.1.5 -p 5000:80 -v /mnt:/var/www/html  -m 500m --cpuset-cpus=0 -c 500 -it --name apache  centos /bin/bash


where -c = cpu-shares =the default cpu share is 1024 i.e considered to be 1 Ghz 
cpuset-cpu=To assign specific core to container where 0 is first core
-m = memory

To check how much RAM docker container is using

#docker stats -a centos7 --no-stream


For more updates visit:
https://goldmann.pl/blog/2014/09/11/resource-management-in-docker/#_cpu


--------------------------------------------

Building Docker image 

For this we create a Dockerfile and run these commands 

#docker build -t image_name  .

#docker run -it --name container_name  image_id


To build multiple container in single time we use docker-compose as it is a part of continous deployment.

--------------------------------------------
Continous deployment part :

For that purpose we need to create a dockerfile to build OS image
and to automate all build also to provide particular networking and volume so that we dont need to pass
extra argument while docker run to that docker image 
we need to create yaml file using docker compose 

9. First creating Dockerfile (name of file should be same as Dockerfile)
    sample docker file:
    
    FROM centos
    RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
    EXPOSE 80
    CMD ["/usr/bin/bash"]
    
 10. Sample yaml file to automate build 
    
version : '2'
services :
    apache:
        build: .
        ports:
            - "5000:80"
        volumes :
            - .:/var/www/html
           
    
    
    To run this yaml use
         
    #docker-compose up -d           where -d is used to run container in background
    
    
    To run multiple container at single time
    
    #docker-compose up --scale [SERVICE=NUM...]
    
    For eg.
    
    docker-compose up --scale web=2 worker=3

    
    ---------------------------------------------------
    
    Docker cluster
    
    11. Docker swarm: 
     
     It is the default cluster software available in docker engine first you need to initiliaze it 
     
     #docker swarm init --advertise-addr 192.168.1.10
    
    To check cluster nodes of swarn the default you see a leader machine 
    
    #docker node ls
    
      
    To check node info user
    
    #docker node inspect hostname --pretty
      
    To create a new manager node we need token 
    
    #docker swarm join-token manager
    
    similarly to join new worker from manager node we need token to add worker to that manager node
    
    #docker swarm join-token worker    
    
    To leave Docker cluster service run this command on that docker node
    
    #docker swarm leave
    After that you need to remove it from cluster service from manager node
    #docker node rm  <node-name>
    
    Some of the DOcker-Swarm Management commands
    
    #docker node update --availability drain <hostname>
    #docker node update --availability active <hostname>
    #docker node promote <hostname>
    #docker node demote <hostname>
    #docker node update  --label-add Env=Dev <hostname>
    
    Now using swarm we create our container now using "service" module and it take care of all the features we want to add in container 
    For eg.
    
    #docker service create --replicas=2 --mount type=volume,source=important_data,target=/var/www/html,volume-driver=local --name apache  centos 
    
    Here replica run the no. of container of the provided image
    
    After that to check the cluster containers use
    
    #docker service ps apache
    
    To scale docker container (it should be in replicated mode)
    
    #docker service ls
    
    #docker service scale <service_name>=5 
    
    To scale down
    
    #docker service scale <service_name>=1 
    
    To remove
    
    #docker service rm <service_name>
    
    
             
