# dnmp
A dockerfile for DNMP image (PHP+SWOOLE+REDIS)

Usage

To create the image Chiangmacrokuo/dnmp, execute the following command on the dnmp folder:

docker build -t Chiangmacrokuo/dnmp .

You can now push your new image to the registry:

docker push Chiangmacrokuo/dnmp

Running your DNMP docker image

Start your image binding the external ports 80 in all interfaces to your container:

docker run -d -p 80:80 Chiangmacrokuo/dnmp

Test your deployment:

curl http://localhost/

Hello world!
Loading your custom PHP application

In order to replace the "Hello World" application that comes bundled with this docker image, create a new Dockerfile in an empty folder with the following contents:

FROM Chiangmacrokuo/dnmp:latest
RUN git clone https://github.com/username/app.git /usr/share/nginx/html
EXPOSE 80
CMD ["supervisord","-n"];

replacing https://github.com/username/app.git with your application's GIT repository. After that, build the new Dockerfile:

docker build -t username/my-app .

And test it:

docker run -d -p 80:80 username/my-app

Test your deployment:

curl http://localhost/
