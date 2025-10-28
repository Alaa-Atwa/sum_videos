FROM apline:latest 

RUN apk update && apk add --no-cache exiftool bash 

WORKDIR /app 

COPY sum_videos.sh /app/sum_videos.sh  

RUN chmod u+x /app/sum_videos.sh 

# creating a volume for the user to mount the data to it.
VOLUME ["/data"]  

CMD ["/app/sum_videos.sh", "/data"]

