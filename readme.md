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


