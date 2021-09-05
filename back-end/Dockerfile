FROM openjdk:8
EXPOSE 8080
RUN mkdir /messenger
WORKDIR /messenger
COPY . .
CMD ["mvn", "spring-boot:run"]