const { noise } = await import('@chainsafe/libp2p-noise')
const { yamux } = await import('@chainsafe/libp2p-yamux')
const { unixfs } = await import('@helia/unixfs')
const { bootstrap } = await import('@libp2p/bootstrap')
const { identifyService } = await import('@libp2p/identify')

const { dcutrService } = await import('@libp2p/dcutr')


const { tcp } = await import('@libp2p/tcp')
const { MemoryBlockstore } = await import('blockstore-core')
const { MemoryDatastore } = await import('datastore-core')
const { createHelia, libp2pDefaults } = await import('helia')
const { createLibp2p } = await import('libp2p')
const { ipns } = await import('@helia/ipns')
const { gossipsub } = await import('@chainsafe/libp2p-gossipsub')

const { peerIdFromString } = await import('@libp2p/peer-id')
const { pubsub, helia, } = await import('@helia/ipns/routing')
const { mfs } = await import('@helia/mfs')
const { mplex } = await import('@libp2p/mplex');

//const { webRTC, webRTCDirect } = await import (  '@libp2p/webrtc')
//const { webSockets } = await import (  '@libp2p/websockets')
//const { webTransport } = await import (  '@libp2p/webtransport')

const { ipnsSelector } = await import('ipns/selector')
const { ipnsValidator } = await import('ipns/validator')
const { kadDHT } = await import('@libp2p/kad-dht')
const { autoNATService } = await import('@libp2p/autonat')



async function createNode() {
  const blockstore = new MemoryBlockstore()
  const datastore = new MemoryDatastore()
  const libp2p = libp2pDefaults()

  libp2p.addresses.listen = ['/ip4/0.0.0.0/tcp/3027']

  libp2p.services.pubsub = gossipsub();
  //delete libp2p.peerDiscovery;
  //delete libp2p.services.relay;
  //delete libp2p.services.delegatedRouting;
  //delete libp2p.services;
  console.log(libp2p);


  return await createHelia({
    datastore,
    blockstore,
    libp2p
  })
}



const node1 = await createNode();
await new Promise((resolve) => setTimeout(resolve, 2000));
node1.libp2p.getPeers();


const fs = mfs(node1);


const encoder = new TextEncoder()
await fs.writeBytes(encoder.encode('Hello World 301'), '/hello.txt')


const name1 = ipns(node1, {
  routers: [
    helia(node1),
    pubsub(node1),
  ]
})

const name2 = ipns(node1)


await name1.publish(node1.libp2p.peerId, fs.root)
await name2.publish(node1.libp2p.peerId, fs.root)

console.log(node1.libp2p.getMultiaddrs()[0]);


//await fs.writeBytes(encoder.encode('Hello World 302'), '/hello2.txt')
//await name1.publish(node1.libp2p.peerId, fs.root)