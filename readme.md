This is me understanding how messaging queue service work. There are different MQ services but I will be working mainly on IBM MQ.

What are message queues?

Well, It's a form of asynchronuous communication between two different applications that wants to talk to each other, I guess we could use a REST API for this situation but there are many things to consider, If we want more applications to talk to these two applications we will need to build or write a different code for each application to communicate to them. 

A queue involves four components:

- Message: The data or payload that is sent from the producer to the consumer.
- Producer: The entity (application or service) that creates and sends messages to the queue.
- Consumer: The entity (application or service) that receives and processes messages from the queue.
- Queue: The intermediary storage where messages are held until they are processed by consumers.

A MQ helps take care of:
- Comms between your applications.
- Security
- transactions
- persistence
- Scalability
- Recovery.

IBM MQ:
IBM MQ is a robust, reliable, and secure messaging solution. It simplifies and accelerates the integration of different applications across multiple platforms, and it supports a wide range of APIs and languages.

It enables applications to communicate and exchange data in a reliable and scalable manner, that decouples one application from another. MQ assists the integration of applications running in different frameworks, languages, platforms, clouds and locations. You can write applications how you want, in the knowledge that you can rely on MQ to smooth out the problems and join them together.

Working with IBM:

We will be making use of the containerized solution of IBM MQ because it has all requirements configured. Ensure you have docker installed on your system or check https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://docs.docker.com/engine/install/&ved=2ahUKEwj4gMD3kpaHAxUTSkEAHcG_BF8QFnoECB4QAQ&usg=AOvVaw3oxUtu6GW_HNWz3ZCPMLU_ 

- pull IBM MQ official image: 

        docker pull ibmcom/mq:latest

The next step is to create a docker volume where our queue data will be stored for reference purpose. run:

    docker volume create qm1data

Spin up a container: 

    docker run --env LICENSE=accept --env MQ_QMGR_NAME=MQ1 --volume=qm1data:/mnt/mgm --publish 1414:1414 --publish 9443:9443 --detach --env MQ_APP_PASSWORD=passw0rd ibmcom/mq:latest

MQ_QMGR_NAME=MQ1: queue manager called MQ!
--publish 1414:1414= port where applications use to reach mq
port 9443: port to mq console

After creating our container we can enter into the container using the exec and bash command:

    docker exec -t <container-name> bash

Components of Message Queues:

Message involves thing you want your applications to send to make stuffs happen in MQ. It involves:

- payload which is the data we want to send  e.g "update database", or "run this applcation".
- Message Descriptor which have control over the information that gets used to process the message.
- Message properties contains information which you can specify in your messagibg app.
- messages can be set to be persistent and resistent to failures when we use ibm mq in production environment.
- You will also need a messaging endpoint to be able to send and recieve messages. 

Queues: this is where we store messages until it is taken.

Event driven messaging: having applications communicate with each other

Exactly-once messaging: When we put a single message on the queue and we want it consumed once at the other end. it is also referred to as point to point messaging.

Publish-and-subscribe messaging: is a kind of messaging that involves programming pattern for building event driven decoupled applications. Put a message to a topic and watch it get consumed by multiple apps.
Queue Manager: a queue manager can be seen as the brain of the system that acts as a server for messaging. they host the queues and topics.they are siply the MQ servers that host the queues.

MQ networks: are loose collections of interconnected queue managers, all working together to deliver messages between applications and locations.
channels: are ovject that are used to send messages from place to place and how queue managers communicate wtih each other.
MQ clusters are tight couplings of queue managers, enabling higher levels of scaling and availability. They help to:
- balance application loads
- data replication
- use standby
- queue managers.

Point to point messaging: sending messages between two different applications. The message can be configured to be sent exactly once. Most like scenario where point to point messaging comes in place is an online store where people make purchase of different items, at every order the database needs to be updated. This update will take place one after the other so that there won't be any loss of data.

Publish and subscribe: it's an event driven pattern, when an event happend, it sends a publication to a topic. a subsriber can be any application that is interested in the message being sent.

Request-response messaging: is built on top point to point messaging. A point to point message is sent to a consuming application and you want a reply back. Using a request response queue lets you have a decoupled application so that they are not dependent on each other.

Message Expiry: setting up a message to be used or processed within a certain amount of time. This is useful when you're dealing with information that needs to be current.

Messaging is made up of simple components 
you can build powerful solutions 
Your messaging software takes care of the details.

Moving on, here's how we can fit IBM MQ into your application code. If you want your app to do something real quick you are forced to use REST but you wont get asynchronous messaging, short delivery and you won't use powerful messaging transaction patterns.

For a better solution:
- write messaging code to an API
- This calls messaging client libraries
- It also takes a lot of work for you.

The messaging code will:
- Communicate with queues
- use powerfull messaging patterns
- deal with security

Developing a point-to-point app with JMS and IBM MQ.

For this test we will be using JMS for java 2 platform.
JMS stands for java messaging service. The JMS API is implemented by messaging service providers like IBM MQ to allow JMS client applications to access the provider's messaging service. 

Steps:
- a queue will be created.
- a message will be sent into the queque, ready to be consumed.
- an application to consume the message.
- Impplement JMS API to your application to connect with ibm(messaging provider).

With the JMS API, our application will be able to:

  -  Connect to the queue manager
  - Open a queue
  - Put a message
  - Get a message
  - Close the queue
  - Disconnect from the queue manager

When we created our MQ server running in our container, we created it with a queue manager called MQ1. you can view this on your ibm console on:
https://localhost:9443/ibmmq/console

to login: username: admin, password: passw0rd

A queue and channel were also created during server deployment. (this only comes with the containerized version)

resources created:

    Queue manager QM1
    Queue DEV.QUEUE.1
    Channel DEV.APP.SVRCONN (For IBM Cloud users: Channel CLOUD.APP.SVRCONN)

